Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D661CA9EC5
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 00:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2686E6090B;
	Sun, 11 Oct 2026 00:37:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8y-jbxB5hFLF; Sun, 11 Oct 2026 00:37:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6A0F9608EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791679063;
	b=U85tQi5MMdh20Yv67NxpCSxvejK0pwLqU4zfuAIteKPSl8k9jr1OpVoIFKcSSr6186j9
	 Eitl4XCahhHeG9Zc/8J7yIgqv229SqgJHIvG9RyOrSrvMVyzwqvGQWzB5pOsapplVXOnM
	 nCTUxIm3tB4i/oyxZc/RxO5maSKYWwlxWwIWSfvHOMSTqHAalqYmSi2Kzw8XrMf7dPIPO
	 ynOXHX0ehBU9iNAVNy37N+sbpY38dDGbnszvKABje8sIOsk2eIhyZ+mGgTWGTuQXHphb5
	 thdN7ffv9rleZSI97XektcrcWz+D4eIB+3hKG+9fSyGrZd60lxwCJzXL/8nTq8P3SGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791679063;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7o2ZHxngKMSuJwuOggzrozZCGd+93u8MYHHxyn/nkXQ=;
	b=QnXkTSYYpGy4IxXRCdFsaCK7UrOrUFjTj1/fRRjRiGHpQHgOUwpQ2yWVcoe6/4gzAaAn
	 3HOZ296r0VwFMSIDcR/ZBeG2filTXxpEALmfmRcWr8hVV1kd5hqCjY3LKX0YYRZjL3OLJ
	 qEM7V933L/UjrA4otmvkPhet1/AxK7g8SAMUBj+3rdBXx0FrYM32htHh3SrXitgjOKelH
	 iD/iKfT5VpD/MQdz+zB50rNqMlDppt3NuGgOcq1RHjF4sox4Xlks+EE6j2f03vqlNDtas
	 R+T7rFCFqohuI+0yxwoPr75nZL6FjUFnXjw0tZcJP3d0RMOYM4T+Yb/t+w9QjPYdheQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791679063;
	bh=7o2ZHxngKMSuJwuOggzrozZCGd+93u8MYHHxyn/nkXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WqMRN+oS93wiM8bqcHAWb1DeV7qiXjOUdkoy5C2G7PiWzY1bOthho74dWa1iL6Aw3
	 m+ZjtRU4LIpbtTd73hAgmbBpzuKqFsgwXUK1CNJxXLpFo4z6dCMr5qItmhrTwxezxT
	 PZ0eGCqRhQ926PHtND2GRMH9i6YEl44CerdkDYyxj+AB6+x6s7L8mzoTvJdYRJ6adM
	 U6fCrx9+JLi3V64b3jVilpJ5KiDl2oEF5imcw56+7y3J8lZ6PlcuSZEZIDJPwQZQlv
	 31UOK5yCyzj22uksm6jR1bomIbSwRxUXTAKCINCjOi7WwMZp1xg6fmSLVHpofBHWJI
	 WOz+5/bPxj9ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A0F9608EC;
	Sun, 11 Oct 2026 00:37:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D0E922B
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 00:37:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 510184008A
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 00:37:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZtMOC6Np31xX for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 00:37:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 51D2F400A8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791679058;
 b=SarogFyZ6v+ogYzcFO3QMQ2BghZ3eAoO4O4W5hwIKD3oG2RCVlpYg97NJ6OS8gPkvlAM
 UCQGa+VH5KkgoTDTYhOfnqYxUTRwZwhLmkfGMOHijxjFXZFSMnYeyghQm4XoWMIctvFm4
 VfOL2F+s3Cx+pBwvcu6Q8yk3eBXqHTFK64i/iLqKSyPiK0mquaNKTTsrYDueL9JFkJt0i
 v+aM5hdaemMNauUHaVHGY+tUgd/CDDtTh/r9/yDKce4XMUvU8SC4KdPbrZh1DCaVNBGs4
 HdH1qwSJVun8CvHI1HR+1auW9x4rpsAWmcBFqH4YBg9C/Qus9JZexvEQx2ZDxLyJalg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791679058;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=7o2ZHxngKMSuJwuOggzrozZCGd+93u8MYHHxyn/nkXQ=;
 b=EdVUPsD1DvUXbNS15bg3XE1xJcEGyt7x7Ls3IKauc2SIcvuIPwjmi9Pyvw5ykXsDelLB
 CxazAvCVXgfCLfYN1NwhCqX0SdXpkjZh5GuSPpS8BPWvsgD7gxmtG3Llxv19Q6dygk2WL
 YLaaccaC5AY36WLiLxFWnisSFgV5KNqfTff2FZ9wUpmtby0x+5ntcsWbeUro3jgGZzvN+
 3AducR1D1c3oFNX8PD8N2iJVhplm0GTp4d8oFcH3MONLKds1m5TtBIKaxmxslCtlZd4XD
 FTsBPh7gXMMwoRiNRrsoEjOSHK3YsDsPnjmSS9rhp3m6txgXZG2CpAbaIgLu+EBwbMw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LX5GOM0V; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=LX5GOM0V
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51D2F400A8
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 00:37:38 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-4911df1e196so510250fac.1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 17:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791679057; x=1792283857;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7o2ZHxngKMSuJwuOggzrozZCGd+93u8MYHHxyn/nkXQ=;
 b=LX5GOM0V/4NmhrfpROZP5NlEXtV1oG2tUxjM3L3T1+O9gheewYb+n9gqoysMSiSUUT
 s1FjWryKsjEQyNd2Pmj/4Vl7IWbiiQkMBluz2w2oBkkZuj0CZW3fr4Mr7R8xAZGqkB17
 F6WPj1aqqAPn7MRJkgA83sSxM8NHZH6W9u7QLyKFU72UccqbIYpFQ58zb3SmmNxOf2Gm
 MCl1Kxwc1mRWZU3VhV2Aj3Rx1XoKaDApJVrueVdSYUNH1KKFS5aBf17XySU1SHB3OGyt
 lj4MQl3reSI8MMGugZkuRYBNW8yVARiaAu2ge/IKdFMajvyPGMrrz68Fh2jU4rHGqx8l
 Ehcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791679057; x=1792283857;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7o2ZHxngKMSuJwuOggzrozZCGd+93u8MYHHxyn/nkXQ=;
 b=VJZUQkmNDYTfP38gIVU0FdFlZjaGtKg0xtvoYbIGbk8qMQw0awgiu48H6MEj7pMDQW
 X1VyfoDM27yr7/vtab1qKfIDBnCkyjadBEnxaaDXhbIyP7s8ufhhloRe3+wiOV2kdzpV
 Z5B8PRZQKIXFG5V3nTwUlFDPi6pG8U3Z/EicoA4npiAwkq9HjXjLwWFNSfO/IT8yyZTx
 Qi0nntnQnjro0jEMaTk90QGkryA9AyQZRXdHFzTOFp83fBfQa9GM6mbu6Em+tT5QVTAx
 LUd6RqUHRY8G22qmlSkApn3fjODIvFyFx9ScqlzKHnWsft9CMDENB7TXQPPMEPygPl/i
 l6zw==
X-Gm-Message-State: AFq9FYLItWDw1F+hkTSpjXs4nSjiluuPjdoZoUCC51pVfZrrXvgKXZ5v
 jmY7wnGnZBkrRvABKvxR8IxsAYGVZhDcmpF/hbuaPb0mIIl/Gtn7nsYDgeideQ==
X-Gm-Gg: AYBFou3pPhIaKmMzX3d0TZasfEOfJJ1icrIakGyI7V7iAL+T05Hv8FkQeg9kf855VLp
 HvQZ67Ir5UvXCZrJZQWTukYIZVQC2V7UE+BwwwNg7jcWZEQ0Qf1Hf9H7U+mhiJ3PjymPNcMIbNK
 tFz4hbDBjNCDJUCaE54QmYLqKnCZBIwfF+eJHpfTgz6L5Vepccly4BmfK9J4x+ifpbH6mGoGCQT
 +ovKF1Jr0yNZAj/Pl1Gc8qXVrYT3tUxE2GvbKqeqyfwek/KFQv6yNoBD8gLdnzgVvllGjOtYrbR
 K7YJuoQ01X9r+jIpLRbawh/+WckQAI/BqNZ16NE0VZQQ0hgxgmo60a9zyXDUWsEPvoX51eV1k0m
 qDtkSbsJ6FzrZ0x2rhaOys9vdvPjR9/ujl0scAvSd1hoj9NVZNnMfi2pEj26q4Xc6EertRQdVIy
 WvDr+0UMs75ilWji/9rMOQEE+nviUqIthE1lkQL1BsRnY83N7H4HXJiJtqf57edrOMu7rKd5596
 ZkJgJrrFoUvyHK9qTkfkVmhBT9SQWc8C+v+0mUEMQhBzmUAfVWxhrfCDBOCrcUYdQKmv0jJSFDv
 BSkX8jvoB16Jj/EJnZVVRT0im6IGx09SRd8yAioK74OAWyP5LOUHncFSZ+aAz4g4krnF4b9jz76
 rd/YMOX5ACkYGhsC55cAnrRpKH7XXt+8m
X-Received: by 2002:a05:6870:314:b0:46a:c0f8:ad3a with SMTP id
 586e51a60fabf-4a2a8708fe5mr4988264fac.8.1791679057070; 
 Sat, 10 Oct 2026 17:37:37 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a84a1457sm5386985fac.4.2026.10.10.17.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 17:37:36 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 10 Oct 2026 18:37:04 -0600
Subject: [PATCH 09/16] net: keep internal TFTP and DHCP downloads from
 automatically booting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-submit-lwip-tftp-combined-v1-v1-9-cf8002c6f401@gmail.com>
References: <20261010-submit-lwip-tftp-combined-v1-v1-0-cf8002c6f401@gmail.com>
In-Reply-To: <20261010-submit-lwip-tftp-combined-v1-v1-0-cf8002c6f401@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Internal consumers need to inspect or use the downloaded data before
deciding what to boot. Suppress autostart around their network commands
and restore its exact value on every return. Route the TFTP helper, DHCP
helper, PXE file callbacks, EFI device-tree download and lwIP net_loop
shim through the download-only path. Keep the argv form so legacy IPv6
arguments are preserved.

Reuse the common protection from the automatic-update timeout helper
instead of maintaining a separate autostart override. This protects
script, EFI, PXE, update, DFU and bubt callers before command autostart
is enabled for lwIP.

Leave an already-disabled autostart value untouched, including a
read-only setting. If autostart is enabled and cannot be suppressed,
fail without starting the download.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 boot/bootmeth_efi.c  |  3 +--
 boot/bootmeth_pxe.c  |  3 +--
 cmd/pxe.c            |  2 +-
 include/net-common.h | 17 ++++++++++++--
 net/net-common.c     | 64 +++++++++++++++++++++++++++++++---------------------
 5 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index e187dc39912..b315f41d870 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -221,7 +221,6 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 {
 	char file_addr[17], fname[256];
 	char *tftp_argv[] = {"tftp", file_addr, fname, NULL};
-	struct cmd_tbl cmdtp = {};	/* dummy */
 	const char *addr_str, *fdt_addr_str, *bootfile_name;
 	int ret, arch, size;
 	ulong addr, fdt_addr;
@@ -289,7 +288,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	if (!bflow->fdt_fname)
 		return log_msg_ret("fil", -ENOMEM);
 
-	if (!do_tftpb(&cmdtp, 0, 3, tftp_argv)) {
+	if (!tftpb_run_argv(3, tftp_argv)) {
 		bflow->fdt_size = env_get_hex("filesize", 0);
 		bflow->fdt_addr = fdt_addr;
 	} else {
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 7e999730e6a..27f254b9f93 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -102,7 +102,6 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 				  enum bootflow_img_t type, ulong *sizep)
 {
 	char *tftp_argv[] = {"tftp", NULL, NULL, NULL};
-	struct pxe_context *ctx = dev_get_priv(dev);
 	char file_addr[17];
 	ulong size;
 	int ret;
@@ -111,7 +110,7 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 	tftp_argv[1] = file_addr;
 	tftp_argv[2] = (void *)file_path;
 
-	if (do_tftpb(ctx->cmdtp, 0, 3, tftp_argv))
+	if (tftpb_run_argv(3, tftp_argv))
 		return -ENOENT;
 	ret = pxe_get_file_size(&size);
 	if (ret)
diff --git a/cmd/pxe.c b/cmd/pxe.c
index 3deae5e6d47..9635c834eb4 100644
--- a/cmd/pxe.c
+++ b/cmd/pxe.c
@@ -42,7 +42,7 @@ static int do_get_tftp(struct pxe_context *ctx, const char *file_path,
 		num_args = 3;
 	}
 
-	if (do_tftpb(ctx->cmdtp, 0, num_args, tftp_argv))
+	if (tftpb_run_argv(num_args, tftp_argv))
 		return -ENOENT;
 
 	ret = pxe_get_file_size(sizep);
diff --git a/include/net-common.h b/include/net-common.h
index 12c1689bf57..d5a95075ad7 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -504,7 +504,8 @@ int net_loop(enum proto_t protocol);
  * dhcp_run() - Run DHCP on the current ethernet device
  *
  * This temporarily sets autoload and restores its exact original value,
- * including NFS and an unset variable.
+ * including NFS and an unset variable. Downloads never automatically boot;
+ * the caller owns the resulting image. The autostart variable is restored.
  *
  * @addr: Address to load the file into (0 if @autoload is false)
  * @fname: Filename of file to load (NULL if @autoload is false or to use the
@@ -527,7 +528,7 @@ int dhcp_run(ulong addr, const char *fname, bool autoload);
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 /**
- * tftpb_run() - Run TFTP on the current ethernet device
+ * tftpb_run() - Download via TFTP without automatically booting the image
  *
  * @addr: Address to load the file into
  * @fname: Filename of file to load (NULL to use the default filename)
@@ -535,6 +536,18 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
  */
 int tftpb_run(ulong addr, const char *fname);
 
+/**
+ * tftpb_run_argv() - Run TFTP arguments without automatically booting
+ *
+ * Preserves the exact autostart value on success and failure. This form also
+ * supports the legacy command's optional IPv6 argument.
+ *
+ * @argc: Number of command arguments
+ * @argv: Command arguments, including the command name
+ * Return: command status (see enum command_ret_t)
+ */
+int tftpb_run_argv(int argc, char *const argv[]);
+
 /**
  * tftpb_run_timeout() - Download via TFTP with an initial server-probe timeout
  *
diff --git a/net/net-common.c b/net/net-common.c
index c5d13a23b09..85d97cb660c 100644
--- a/net/net-common.c
+++ b/net/net-common.c
@@ -64,11 +64,40 @@ void net_sntp_set_rtc(u32 seconds)
 	       tm.tm_hour, tm.tm_min, tm.tm_sec);
 }
 
+#if defined(CONFIG_CMD_DHCP) || defined(CONFIG_CMD_TFTPBOOT)
+/* Internal downloads return data to their caller; only commands may boot it. */
+static int netboot_run(int (*command)(struct cmd_tbl *, int, int, char *const []),
+		       int argc, char *const argv[])
+{
+	struct cmd_tbl cmdtp = {};
+	const char *value;
+	char *saved;
+	int ret, restore;
+
+	/* An already-disabled setting may be protected against writes. */
+	if (!env_get_autostart())
+		return command(&cmdtp, 0, argc, argv);
+
+	value = env_get("autostart");
+	saved = strdup(value);
+	if (!saved)
+		return CMD_RET_FAILURE;
+	if (env_set("autostart", "no")) {
+		free(saved);
+		return CMD_RET_FAILURE;
+	}
+	ret = command(&cmdtp, 0, argc, argv);
+	restore = env_set("autostart", saved);
+	free(saved);
+
+	return ret ?: (restore ? CMD_RET_FAILURE : CMD_RET_SUCCESS);
+}
+#endif /* defined(CONFIG_CMD_DHCP) || defined(CONFIG_CMD_TFTPBOOT) */
+
 #if defined(CONFIG_CMD_DHCP)
 int dhcp_run(ulong addr, const char *fname, bool autoload)
 {
 	char *dhcp_argv[] = {"dhcp", NULL, (char *)fname, NULL};
-	struct cmd_tbl cmdtp = {};	/* dummy */
 	char file_addr[17];
 	const char *autoload_env = env_get("autoload");
 	char *saved_autoload = NULL;
@@ -91,7 +120,7 @@ int dhcp_run(ulong addr, const char *fname, bool autoload)
 		dhcp_argv[1] = file_addr;
 	}
 
-	result = do_dhcp(&cmdtp, 0, !autoload ? 1 : fname ? 3 : 2, dhcp_argv);
+	result = netboot_run(do_dhcp, !autoload ? 1 : fname ? 3 : 2, dhcp_argv);
 
 	ret = env_set("autoload", saved_autoload);
 	free(saved_autoload);
@@ -113,17 +142,21 @@ const struct tftp_request_timeout *tftp_get_request_timeout(void)
 	return tftp_request_timeout;
 }
 
+int tftpb_run_argv(int argc, char *const argv[])
+{
+	return netboot_run(do_tftpb, argc, argv);
+}
+
 int tftpb_run(ulong addr, const char *fname)
 {
 	char *tftp_argv[] = {"tftpboot", NULL, (char *)fname, NULL};
-	struct cmd_tbl cmdtp = {};      /* dummy */
 	char file_addr[17] = {0};
 
 	log_debug("addr=%lx, fname=%s\n", addr, fname);
 	sprintf(file_addr, "%lx", addr);
 	tftp_argv[1] = file_addr;
 
-	int result = do_tftpb(&cmdtp, 0, fname ? 3 : 2, tftp_argv);
+	int result = tftpb_run_argv(fname ? 3 : 2, tftp_argv);
 
 	if (result)
 		return log_msg_ret("res", -ENOENT);
@@ -136,37 +169,16 @@ int tftpb_run_timeout(ulong addr, const char *fname, ulong timeout_ms,
 {
 	struct tftp_request_timeout timeout = { timeout_ms, max_retries };
 	const struct tftp_request_timeout *saved = tftp_request_timeout;
-	const char *autostart_env = env_get("autostart");
-	char *saved_autostart = NULL;
-	int restore_ret = 0;
 	int ret;
 
 	if (!timeout_ms || timeout_ms > U32_MAX / 4 || max_retries < 0)
 		return -EINVAL;
 
-	if (autostart_env) {
-		saved_autostart = strdup(autostart_env);
-		if (!saved_autostart) {
-			ret = -ENOMEM;
-			goto out_free;
-		}
-	}
-
-	/* Updates need the downloaded data, not the command's automatic boot. */
-	ret = env_set("autostart", "no");
-	if (ret)
-		goto out_free;
-
 	tftp_request_timeout = &timeout;
 	ret = tftpb_run(addr, fname);
 	tftp_request_timeout = saved;
 
-	if (env_set("autostart", saved_autostart))
-		restore_ret = -EINVAL;
-out_free:
-	free(saved_autostart);
-
-	return ret ?: restore_ret;
+	return ret;
 }
 
 #endif

-- 
2.53.0

