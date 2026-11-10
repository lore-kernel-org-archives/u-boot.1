Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE15606A336
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gxrKv15g;
	dkim=pass (2048-bit key, unprotected) header.d=timsurber.de header.i=@timsurber.de header.a=rsa-sha256 header.s=MBO0001 header.b=etuoULSm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BE0C80D91;
	Tue, 10 Nov 2026 13:05:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ylP9jx5Ju_sB; Tue, 10 Nov 2026 13:05:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E2DA38120B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315921;
	b=pF8SqZ4P4FLVH8WGXNUNdPXC99CbD1MC1X6vleUhQ3VUwrni19DwQjUfvZUk/mwgBS6r
	 jV5vO9q+c02EG4nNvuuLj9KT0gmPV5Z3D9ysW6xwS8cA1WNDzMmz2Qc827BStxYgpqByB
	 wGQV50JTA9ryBMaoP1Om83SI9UbozFPzhoypnS2ak5cFJF5MpCXoOhKcD68TKD3fI6Rfe
	 yH+UsFYF9yQIbMWW+HBCLVhDrHtf7FmpcbeVOTrPIdEiSF2+VEs27QsNaw64gSQEq6rYk
	 +eyVweAz2RE5VOfCwNf0jUyiWjOC9bFIWCocjBpwHmPn68eB3ebZE6UQ1+q7njkS7hQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315921;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Message-ID:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Priority:Importance:X-Mailer:
	 X-Originating-Client:X-Rspamd-Queue-Id:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/VDEv4Pa+ZTwjIN8dp4zNtFIX5pVT6VLUYiYUaip1HQ=;
	b=qSnmJgMHLbrIQjAjX3cMT8TBfA2C9IuqcHoYyUGIW2R3vRF53pLFQNlZ7A4upmWSIYhJ
	 3yNDwVBsGk/Jq12fc97vfSRtvmM8U8XCGJb0dWl672AKbRIwCsVVaglOf28q4aTrqRyIn
	 P3VGmHrte4RaeJS8F2CjSIwPELukxAlFaQX1gOGU8VIWjOD1ETyENDtR7dTu9WVRhLsZV
	 F4M0/zvAW+nXAfIT9Pvb7YdsWiR/N0wQvipmWxaI1vZ2eyQH8urSAY/NBa8dTC4Pqjnd2
	 Vgr0zpsM3/knJzANon8vUHaVJVHoBiAfTHn7OjiF2zO7ecqM9Z7Vxlm9AzAcJSAP6ZQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=timsurber.de;
	dkim=pass header.d=timsurber.de header.i=@timsurber.de header.a=rsa-sha256 header.s=MBO0001 header.b=etuoULSm;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315921;
	bh=/VDEv4Pa+ZTwjIN8dp4zNtFIX5pVT6VLUYiYUaip1HQ=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gxrKv15gVAEs22J5gVIImV+hyh99MhdYaLejBAkISfo69OXyOKDG+UdQhrBjmta/f
	 N+6CMVQEvZfRa9jOvMXeBAtvSUkSNBCsuJ4KBkXsOjm451AHyRK6CEh9XjyPo8dyvp
	 mGPF4Wqamx2Hy+7pFdeGA47UGtKw5/GE09+gdHiQTH9GuAmUqUkjn9EinYGL/mnbQ0
	 jH0xM+yL3lCOtCq/bIQJdYaFBREjwLOqRtkPkpsiOHCBUeiQIThbqVNzKda3I5awfC
	 xXMZAGYMoBEbM3zX7Y36NIhqEQHcysZXmf3e87hXySqvZSVvK17Cc8r506EpvwhhTj
	 hvjzT0IeJ4T6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2DA38120B;
	Tue, 10 Nov 2026 13:05:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ACE391FC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 02:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9865C80BE6
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 02:17:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3bfzo1ni-Vtm for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 02:17:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D7A7380AFE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=me@timsurber.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=timsurber.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=timsurber.de header.i=@timsurber.de header.a=rsa-sha256
 header.s=MBO0001 header.b=etuoULSm
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D7A7380AFE
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 02:17:17 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jNqYk0lZ8zKnQM;
 Tue, 10 Nov 2026 02:58:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timsurber.de;
 s=MBO0001; t=1794275898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/VDEv4Pa+ZTwjIN8dp4zNtFIX5pVT6VLUYiYUaip1HQ=;
 b=etuoULSm/wfyEqr3z0Ykc8dbfQ1DVKujx2zxOTvjcnTOgFpapyFa2vuO+i1Jm+gn+qvN0q
 K+MM8DOHjKGH8VBglosGNG6tPjeqDhpux2te0fOAPAKH22LxOhgoe2z9UegpTtq29qq97+
 PTyAgTI5RGHDy+Occ1DrlQ+epcs9LkI3LbSfgbDkeEG48fbP/cdSYZ591tx4M33jEpx4N1
 tFwxpqkemU4+grIpxeWcn+/KnHEDXSwChrtVQB1k4y4DtDY/nTe2a5Eya47cj+76SJeWxC
 jQRArDOSwQwG9oakgz8M6URDk2+bGz9bhQ5eDmCp9niiohDdHkesMaL/Zr0xbA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of me@timsurber.de designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=me@timsurber.de
Date: Tue, 10 Nov 2026 02:58:17 +0100 (CET)
From: Tim Surber <me@timsurber.de>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Alexey Charkov <alchark@flipper.net>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Message-ID: <2113981400.38169.1794275897389@app.mailbox.org>
Subject: [PATCH] boot: pxe: pass the initrd to EFI applications
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.53.348
X-Originating-Client: open-xchange-appsuite
X-Rspamd-Queue-Id: 4jNqYk0lZ8zKnQM
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit 841abbc6d561 ("boot: pxe: support booting PE/COFF EFI
applications") label_boot() runs every image with a PE/COFF header via
efi_binary_run(). That includes regular arm64 distro kernels, which
carry both the "MZ" PE header and the ARM64 Image magic and were booted
with booti before.

The initrd named in the label is still loaded to ramdisk_addr_r, but it
is not handed to efi_binary_run(), so the EFI stub starts the kernel
without an initramfs. With a stock Debian arm64 kernel (storage drivers
and ext4 as modules, root=UUID=) this ends in

  VFS: Cannot open root device "UUID=..." or unknown-block(0,0): error -6
  Kernel panic - not syncing: VFS: Unable to mount root fs

Pass the loaded initrd to efi_binary_run(), which installs it with
efi_install_initrd() so the EFI stub can fetch it through the
LoadFile2 initrd protocol.

Tested on FriendlyElec CM3588 NAS (RK3588) with Debian linux-image-arm64
Fixes: 841abbc6d561 ("boot: pxe: support booting PE/COFF EFI applications")
Signed-off-by: Tim Surber <me@timsurber.de>
---
 boot/pxe_utils.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index c60429a5e1..21b05ff9da 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -807,13 +807,22 @@ int label_boot(struct pxe_context *ctx, struct pxe_label *label)
        if (IS_ENABLED(CONFIG_CMD_BOOTEFI) &&
            efi_check_pe(buf, kernel_size, NULL) == EFI_SUCCESS) {
                void *fdt = EFI_FDT_USE_INTERNAL;
+               void *initrd = NULL;
+               size_t initrd_sz = 0;
                efi_status_t efi_ret;
 
                log_debug("using bootefi\n");
                if (bootm_argv[3])
                        fdt = map_sysmem(hextoul(bootm_argv[3], NULL), 0);
 
-               efi_ret = efi_binary_run(buf, kernel_size, fdt, NULL, 0);
+               /* hand the initrd to the EFI stub via LoadFile2 */
+               if (initrd_addr_str && initrd_addr_str != kernel_addr) {
+                       initrd = map_sysmem(hextoul(initrd_addr_str, NULL), 0);
+                       initrd_sz = hextoul(initrd_filesize, NULL);
+               }
+
+               efi_ret = efi_binary_run(buf, kernel_size, fdt, initrd,
+                                        initrd_sz);
                if (efi_ret != EFI_SUCCESS)
                        log_err("efi_binary_run failed (ret=%lu)\n", efi_ret);
        /* Try bootm for legacy and FIT format image */
-- 
2.53.0
