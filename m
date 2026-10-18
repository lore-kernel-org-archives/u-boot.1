Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ED0CCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 04:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AFD680D09;
	Sun, 18 Oct 2026 04:24:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KRwMy4-1AlHD; Sun, 18 Oct 2026 04:24:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 80A7981265
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792297450;
	b=N26GrXjPpsAo/kHWQadp2aItIgR4qloaxQgXNg1A03o9ESDlUxew6YHXUk9j28qxvrOk
	 tgl4ZC7iG36ewH6u04vC8b8oLqVNGXlf71A9+ZzUf/CtCT5tga+PIK4tbnk/h+t187RQe
	 RziDtVQ0jxDUWqMIiE/nnmfYMPJW8/ldK3oPtEX6utyIyJp3SmsSE3PG8I4uFEn9aYuPO
	 l3OT3SuSQngFB+LE/K1KI5Uc83v0ga8WP1S0iQ5uHHS8OF0XvmJS3oZqJp+rxeyudmaDm
	 aFWpwMCh4UBFGnW583YguxJAOaqET0C9NoWyVzK5J6fcwbyYKCkeT/6BVV9rmFv1gLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792297450;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VDxn1Fkqah/6zqjMX7FtyyBzH7tFtLLb5LEwFW/1VvE=;
	b=SKGd9svcEl+moDPTgl/HYy9VEQ1VEUSgjgGEFpBiDaifAzPKGXJJZni9msWSlmyYrQxO
	 cJ/HCjt/MyyTWxWCxAC3nEFCezuJogHSPhwNxOQhwVPxLo3V//7l3w1Rqtph4V6vakgpF
	 VAWAOxigFD/Ym9YdEE+lsHrmhrD9FfDRA4dGaEcuEyZSXoFT/nZ+wfZoTMVtJhCdm0txF
	 4vLGE1AIK4QiFOMji0SfQ8HR5LPidM8Ym/T1HcRYx1m9LoIA2MsSqMEWTPQkHeBHkbUFx
	 M7JI0NVcWnTrxoj9QM4bFt0xti9DDIhxFsma1isiKFyXFD0gMB2g8JpuTPxD0Y0Jc3g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792297450;
	bh=VDxn1Fkqah/6zqjMX7FtyyBzH7tFtLLb5LEwFW/1VvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i+TpHeQJ5hg1hD0z+XfAFxj+Pqn2CGpENiNRZpz3Kfp/UmtjFJqbZUfd2JR2f0b/L
	 jd94UhTc2n7L5Mf/g+M196bbA65zRU8y7jkjs22qwoXVCJGZzjosrZywjurJohYrq5
	 5ee2i4Y6Hthp/5NM0BpRDohy6gNl7TqAn/7/gbRpRyQ+thdaIvMu1Zd/g0OUzlDrGW
	 X8Xl71dshH273pTDOKhzV1fGB7qvrcdjA8q/ABO33ZxL9WGoC0MHcCQ0qYAVml+5dS
	 e6CFb89vMygPJvvPJXQexhDjp9IUKUmfvCpWW7LViZqUbxEqBw63O+Sn8ZwkYgZ09H
	 imQ+FO02LgFVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80A7981265;
	Sun, 18 Oct 2026 04:24:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CA4A861
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B062B4004A
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZlJt-5UpPRFb for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 04:24:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D328540061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b129"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792297444;
 b=QSlXSlKgCKgkSrYCKbELjDA8ISorZPZfRd7LbZ8ZuhQz0VG9UIWi98js9x/q2XGycSPv
 Y3APvt+O6H4c+GTLGM9BT7wUVaGcjtzOuh053jQYyse19ocRp6OZZ8GJDn/BXIhuEzRoa
 BJB2Vq6q/6wK6wmROdcjvYkGVxjPb8qLtIoWmeTGYtAxLAtU/QSWVPVkKO2bl+YLEhbTp
 tQw7gpQqsr4LCn2tuCah915DYEsYQs6c4VtfxMJ8l/rIGtp0T0UQhW6f2RZF8NDCN/HFF
 3ti9jaOpSa7yhbnVJweXRnriLowlVD/kTG+uq3PGap0RcwYb6nWVC3l8250VcxQF+LQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792297444;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=VDxn1Fkqah/6zqjMX7FtyyBzH7tFtLLb5LEwFW/1VvE=;
 b=eQaOWw0JoxR6i4RcWy6/bLvtexKf1PzBcf/NKjsr5eyS/1Q0WFKb2/trs8oksLfb8FoW
 x6wX4FkhjyBYKnGGY52MJWLtMVZ0rXEZWjP+BtlNRwdsPqVpkeVOgsL2SYDcvBOiJmGZf
 ny3ERL+Tr2si6UJxlCBExb+5HhJEuq16K5lXDNahRp1dxALIBIXB4NhdTb6qvti4DIazs
 azybAAHsOOLpNtKemOTMYgCYN1KPXJ3W/2yyCNYuuJmyABLjYSql6wby03QPU4U6D5Blp
 VQXgp0lKTIRstE4kfus8aC7iwbUoL85tMqjVHpGJkad9bs+7rzcfAM1FIOiWrxo+mmQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=TxU3Al4p; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b129; helo=mail-yx1-xb129.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=TxU3Al4p
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D328540061
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:03 +0000 (UTC)
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-679a420b96eso1071218d50.0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 21:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792297442; x=1792902242;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VDxn1Fkqah/6zqjMX7FtyyBzH7tFtLLb5LEwFW/1VvE=;
 b=TxU3Al4p9OVXDVBJEdhwbL/ZuMgfrYhx9/ng0Pvng5aFYmPYV7/VNlU8Y4uueuuenn
 09QvkJ/boasLgPACe/nG+Q/6sAs9Y9DQ6K27x2Q0i/wLzdDFXQzseQzBXuU4e+IgOP9j
 D1pFhV2VZ9jpC0nixrBwf5lpkINQ7jHfDIHWCw9uE8qIoCL8hW8hUFzFoIEY7w0jQ/eO
 FQ4xDx86ab07gW//BX43ukBn63kNrB7vUZoM9ZVCxU9Kg5U/N+gOhW/nRint1KuFHbCJ
 hgwQKI5a+7OLXZeetX2nePHIIZm9BH0y2GfBXNjU550C82Tp6lQ4ODfkjUd70rA3CTNh
 ZouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792297442; x=1792902242;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VDxn1Fkqah/6zqjMX7FtyyBzH7tFtLLb5LEwFW/1VvE=;
 b=cKseMNQyf8JDmXjbZhe708y2dVMGjuqihQgegD3Fzi0ulo9Q9p2lNPRp5mVuKDIJpM
 N0OzgKUif57pE1wG4ZMawyPtmAwl5j7Ej/Hl2rS1CEE6CRFsFi7Mk+ObWwqoq8YFyNut
 Q5+4jD3F3Bt3oiZD8lTwY4cJEjXgy40EMCFbUCfiqh5VSBru/xG0a8KPwX/cqEfd1Rd2
 OuDErFWPT+fRkSIkok/lerDbyV7SVniDEI6cIDxQ4LZ3yDHRiIhqf0plv8oPAc0DKvd6
 Ns+LbuaBWgs/iZenSmg4qin0GS9SBPVsdYwmdCnjRo+8NusjxvU7+0avsZhKtJ01p1g4
 ncwA==
X-Gm-Message-State: AFq9FYIE/TAU1jh9VBureFVdvRerPtaztlx4vmjaF4e5KID7YmNdhlQs
 Lw9a255878ZC011sK8XV+oZLp4jq0OBQPTtHyPRHcVjFQxSdLv5qhuayUCBPpI8yUeA=
X-Gm-Gg: AYBFou3T891hmwNospG++2vFnogobq6dWkV/tevEI0TP3fTkyxJ8hAOJyN1UT3ePsUa
 PJIk29kwxT0USgKWekfDRo+R/ap0eGwwraVICAJqRdghY5pvFO4jLxl2/IotDz2vygWVnW4sIA4
 9Id9H3v3xIlvDyvnI//zGLp93wTsK3oGAgW+gUFxbTLDi1Hn7hTdP45UD3eEa4kIXs4gvGqP6w0
 ySK/0SdVFHV/cVAU7g8JmDyB6zvnyX0jO8uqeUt6fk3aIkLn2x5kebdtD5sOqYB7CcK6mbHdFPJ
 xz/pb33cvFgJs32UUN15AKiIBeRWKn9otd39TFCs692j6xnE7/roHgW8egbYj0946RNodnPbMDY
 DTLngwkbKR9OKNFYWONsf/AD+aZfgbuzneTdcm8QuaKCkzAmL8oFSLFFLwNbP1ToO5mBJw+g717
 kcvy7W1dU2ddXvhM46cXVT9qiAZL4oi7XEmiLHrwD49yfDtLtP/FcGxExBx7XDgoTgi2HCE/S36
 O5wb3hPwaAC7KgPiw6JdcOmSXQfhRobm2ELjLVQIiHQeojnkaF3TQ==
X-Received: by 2002:a53:ac8d:0:b0:678:fa71:3022 with SMTP id
 956f58d0204a3-679ca887f1bmr1068247d50.19.1792297442376; 
 Sat, 17 Oct 2026 21:24:02 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:4b47:590f:51dd:a46d])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-679b1f0e01fsm2838791d50.20.2026.10.17.21.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 21:24:02 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sat, 17 Oct 2026 23:23:47 -0500
Subject: [PATCH v3 2/5] bios_emulator: Don't free a caller's BIOS image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-aspeed_vbios_fixes-v3-2-961124989594@oss.tenstorrent.com>
References: <20261017-aspeed_vbios_fixes-v3-0-961124989594@oss.tenstorrent.com>
In-Reply-To: <20261017-aspeed_vbios_fixes-v3-0-961124989594@oss.tenstorrent.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
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

biosemu_run() can be called with a BIOS image supplied by the caller
(dm_pci_run_vga_bios() calls it with an image, so bios_rom is not NULL)
or with no image so that it makes its own copy from the card's ROM
(BootVideoCardBIOS() calls it with no image, so bios_rom is NULL).

In the first case, the image is either at PCI_VGA_RAM_IMAGE_START
(0xc0000) on x86, or a buffer owned by the caller. In the second case,
the image is a buffer malloc()ed by PCI_postController() (which
biosemu_run() calls). The clean up path in biosemu_run() should only
free up the image in this case.

However, the clean up path frees the image in both cases, which can
result in the freeing up a buffer owned by the caller in the first case
(dm_pci_run_vga_bios()). This can cause a double free when the caller
tries freeing up the buffer again. There is a currently a check to
prevent this from happen on x86 (vga_info->BIOSImage != 0xc0000), but
nothing stops this on other architectures.

Update the clean up path to only free the image when biosemu_run() made
the copy itself (i.e. bios_rom is NULL). The existing checks for
vga_info->BIOSImage not being NULL or 0xc0000 can then be dropped, as
this copy is never at 0xc0000 and free(NULL) is safe.

Fixes: 4c59f9532796 ("bios_emulator: Add vesa support and allow ROMs to be passed in as data")
Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/bios_emulator/atibios.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bios_emulator/atibios.c b/drivers/bios_emulator/atibios.c
index e992a1aa822..b8c962d5832 100644
--- a/drivers/bios_emulator/atibios.c
+++ b/drivers/bios_emulator/atibios.c
@@ -509,8 +509,7 @@ int biosemu_run(struct udevice *pcidev, uchar *bios_rom, int bios_len,
 	*/
 	if (clean_up) {
 		BE_exit();
-		if (vga_info->BIOSImage &&
-		    (ulong)(vga_info->BIOSImage) != 0xc0000)
+		if (!bios_rom)
 			free(vga_info->BIOSImage);
 		free(vga_info);
 	}

-- 
2.43.0

