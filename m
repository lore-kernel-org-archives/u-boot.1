Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DF3CA5FE4
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 20:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 264E1605F5;
	Sat,  3 Oct 2026 20:08:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Pxzk9fxpUKj; Sat,  3 Oct 2026 20:08:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6E0C660624
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791058096;
	b=TohO/YbwTxlD999IPWSZh+GZIvs+Kkjuq585/3yznuN7Xc17HwmKxeTk22QU7Aapq/fA
	 XTXqmNZ+Cw/j0rf0WXDZzLirs6T4YzmONuO1EZZDWYY2yr8fssMoP4+rwRtL0zdpXiU3Y
	 pEprvOg07ceB8iNxWNOL669cuwJhsuwa15X2X1+tlidX8XN4Tdj1HyAGhUlNz9cXuhqjm
	 l68tTvGrMuaXymH3YQw0bXq7NHKaTBfCqY9bB9JtPU7lVE79LZxmPXS8Fj+f+DBAqr3ew
	 tE9Fp7GoB9i/xCNTa/kJgxHbtwxAzq5I5VAmYjHRrBoydyIiJb7CBQgxb06MyejYyaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791058096;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=mytQ65x0k7iWkNsSRLPMajbRVGUGSVvwzzLLvDCwaMc=;
	b=UrVrooMojkPGvu7dXW645/femNdXAYUbfXoAajU1aJkY/VjZFsfQZr7JU8MvIcx/E9ZW
	 NyOPvt3Co+aQsUfKS6Fj8xm8YcH+Dj4XepfnqAUxjv6wOWNpHff1xd6lQ9arOSi0QkNZl
	 41jS0Ga7Tu0S9S1Pj5xG9UBrBeFvVi+E3cBv6VBUh8mlAOF9TyBsPZKM57X/W4jQaSiF9
	 xAXXynoZbopJ//jW1UnfJToZg5N6ICj6t7pxru1nX/Znhsd04rKRHf3go8IagdapAWyiD
	 39AFoQcD4G+OhIfmk97ahLXIUDMIULS/zoRtY4drrmUKXe6t8FfT9K0ItWTtgHiL0IQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791058096;
	bh=mytQ65x0k7iWkNsSRLPMajbRVGUGSVvwzzLLvDCwaMc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MAdkLbc3jWvCOy+Gv60Zny4oP0rMy4VsPXNM/IqYJ/z0tUyNebuA+LJAeTlN/iY4C
	 g1yXVk4kHUa5TY/7TBa/NUcyGwBhokR2fxu4T4Fo9p0yXSMLRRjPryLYd/Tun9D9Mo
	 OijnfdA86F/bd/rPyxtsxnHbmfkosU/S/Bp6kOi7Tyht35wWaGcy1Mmz72HV8DA0pZ
	 DAMSBcfC45b9/WNrzvA8ZADMlW0G3+mcPhfyl8UYDm8XztUFgIlx3/oosaJKoZvg5v
	 a5AR+x5tOyDm+FEDZhPGRq+V9F5gEQXCCie8mrQ9LN/MjkOEo+wX1W4zyPj6K98eXJ
	 rbTPqT1K0iutQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E0C660624;
	Sat,  3 Oct 2026 20:08:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5304A282
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B8A740064
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yp2VRX2TnA21 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 20:08:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 261BC4008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791058090;
 b=SKLs7jcsKBcBuSN8+t6OTG+hx3QdFLVdjWm4r+C9yHoeSso4ucyALZ45+rHVvPzt803S
 ss6kZsj9+J+m9gF1LbHPVTnraYn0UmTG0smaEW8cPeFHjHUS5F8NBW3ooS3MYEnsMcgRk
 O5CfV54BHUyAXfvjAOXRyxeD3mp80ld8Ku9eMEc9U//KUFMEFoCGaAdANN2NbIZPo9diu
 2ng22xZ61Xo8QdS6L9BVJKfUeTSm2hK4cIx2RhmkQx8iLDrNrtuJ37By5q8svpg2JUNlU
 njvtn1+pfJnMQ6CwZE69a9ZFywz2RsrbyTfGPi2ROtxTS0FizG4e/PxLHEW9CGdkTlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791058090;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=mytQ65x0k7iWkNsSRLPMajbRVGUGSVvwzzLLvDCwaMc=;
 b=C/EzzCuUEzE6n20JvnUkRW5Kz2I2R4cowWIZzvQyrzgJYxzLVxAIDG5qy0xGrB3HFSeV
 iUo8f33LwGZzt9jvTAgiFPF48kBUjDtt3/K48PXfcsMv4rl1+nHWfxjR0KuSHPmaJ2h1I
 fdwO0Iaugiv6YaJyLZ5/khTqZIdTucqiEOKuMHwRqDRM1bJPwcxk/bJSRn3u7e7ZFOpwO
 5vgisgEh62mDc2fvZzHKSpxXCLnfV54q1zf66Tt1N1k2hEicnMZPQ+ajmwwu24LrfBQTa
 0i5so3E9/HqOS/ilHIUp48G4raO9UK7IgD6nB6zShqA/mYuCKkZBJWrBNf8frCZZo6A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.tenstorrent.com; 
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=fdmp2H7M; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::11; helo=mail-yx2-x11.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=fdmp2H7M
Received: from mail-yx2-x11.google.com (mail-yx2-x11.google.com
 [IPv6:2607:f8b0:4864:41::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 261BC4008E
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:09 +0000 (UTC)
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4ab201ebso353734d50.3
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1791058088; x=1791662888;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mytQ65x0k7iWkNsSRLPMajbRVGUGSVvwzzLLvDCwaMc=;
 b=fdmp2H7MCe+L/WFXufacfIM8/z/G69D5iCjv8Ke8fnN6j/q/2qxh+vbpcAQUc37T5a
 sIyN+C17xBVDFrwgnUiJGscHb/Z5UmtuMUUsY9KMHfonQ3V9txzzFaOO6HLC3TmM6CMM
 TraheupoxdQOd2CiLB0AUk9KKnGPs1PahDzHvrk4KB22pBnbTgkFTKE2KXVtub6oLMDL
 HBb3RvEnRLCOfp36SbcrfU/GU9wWVZvaw0x1gyzYDGuhS32IVlRvfxVOBWj3L4Rp7HMt
 6LEMN4EmpPHS5s1JdNe0pm62WCB9+qSkBxRCcXzjtx5mKR34uSV9V94WA3yB3ek3d9Kq
 h+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791058088; x=1791662888;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mytQ65x0k7iWkNsSRLPMajbRVGUGSVvwzzLLvDCwaMc=;
 b=Rov77ZFsB5SQO1eJsgAekqc4jq/RSqJyqWG73MOyq+xl93GN7BpZo5bYJIXuF86Ay5
 aGrtzWY7bga5xeCsT+iXoG4OsZ/5gR4CBzLfRsIxZfTljl5FoQcCaK38IurLeU0CKzTf
 1gVzA3pQCVv8PbIQMBUXepgxNH4j29OWDETx4ugy1BMpM7EByDKZpua1SdFoDMMv61Ws
 Lv51klWviADIfXJNWCBeGNTA90oKSBSBefL4e/7rNJFEW/012knwljPo7tAR+TjsKL10
 XCHJwrajnF9bHN/2Vqcu4ZwWSM+PDyg01hqyF/h30GWo9bFMgP/jV/JHaYnKo5mxDGcy
 P5Ow==
X-Gm-Message-State: AFq9FYL5SEhwU5m3pIVv0KXs5vEJSzYxQI1LOOk9bpfzMlXlm+/vb/kQ
 BtuxHGjWELzLnhTwejsrzdpCgcnTVmgqyCgTpF1fMvHMufsJceTt5FbQc2FC0TjPgeAvG3gcjXw
 kj8/o/Vg=
X-Gm-Gg: AYBFou0COUcVO1vGZ6TC1PE9TCbbnOipAk5s0B9JoZ5Ck4hVDBiFwrZE3LAyKKX3aky
 uKwK3h9s2lT+omny654w7OXgu6+9mBH/8TA+SSTkL5cvlj7sI5u222loHh040R6gr578+VFbS/j
 utrlBxgvzboS3W6ENN0MOPiZqBf11nac6xEII/hZdtDkK7Nm2A65het/eBUhy419owEE31IJrIn
 79k1bV3c8nVWynT+ITv/FGjeILK/+LgOskbQC++nU1FYRJ5TxYixPdBCUicZbvpEH41cEhumeXl
 jFpvnE2lW0zboY2Rr6PB4JN03+cvo1dw1WAcTzIY0b/HfRpLPeuxpM5kanEvtvikuyZxXCnHupF
 nbp8CivVcGvq4BU1ElYqTYI4dvyH5RlGGgq/lxGy8arlM2XfEKd/oxKbA3Q0xjoOCPXpZ6m3sv/
 1bkr0sD9ZGqO7icyeDno/7ljFRl1fM62L/Fmn+9UcDt+nVjyX6j/UvriTcPLKXv24cxoE/GAZqY
 krk79DLXpiEoaUgX2yi83e+2PbtoO9vJNfTgmmxlXE5Z2hsPvE5fg==
X-Received: by 2002:a53:ac94:0:b0:677:b45a:d5fe with SMTP id
 956f58d0204a3-677b45adeb3mr1722490d50.61.1791058088550; 
 Sat, 03 Oct 2026 13:08:08 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:e2e9:9d9a:5aeb:a046])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-677c16c243esm986048d50.0.2026.10.03.13.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 13:08:08 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sat, 03 Oct 2026 15:07:56 -0500
Subject: [PATCH v2 2/5] bios_emulator: don't free a caller-supplied BIOS
 image in biosemu_run
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-aspeed_vbios_fixes-v2-2-f8e593f024ab@oss.tenstorrent.com>
References: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
In-Reply-To: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
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

biosemu_run can be called with a BIOS image supplied by the caller
(argument bios_rom is not NULL), or with no image so that it makes its
own copy from the card's ROM (argument bios_rom is NULL).

It subsequently calls PCI_postController, where the BIOS image it runs
is stored in vga_info->BIOSImage. In the first case that pointer is the
caller's buffer; in the second it is a buffer biosemu_run itself
allocated.

The clean_up path in biosemu_run always frees vga_info->BIOSImage. That
is right for the second case, but in the first case it frees memory the
caller still owns. This can cause a double free when the caller tries
freeing this memory again.

Only free vga_info->BIOSImage when biosemu_run made the copy itself (i.e
bios_rom is NULL)

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/bios_emulator/atibios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bios_emulator/atibios.c b/drivers/bios_emulator/atibios.c
index e992a1aa822..ebeeb178b7f 100644
--- a/drivers/bios_emulator/atibios.c
+++ b/drivers/bios_emulator/atibios.c
@@ -509,7 +509,7 @@ int biosemu_run(struct udevice *pcidev, uchar *bios_rom, int bios_len,
 	*/
 	if (clean_up) {
 		BE_exit();
-		if (vga_info->BIOSImage &&
+		if (!bios_rom && vga_info->BIOSImage &&
 		    (ulong)(vga_info->BIOSImage) != 0xc0000)
 			free(vga_info->BIOSImage);
 		free(vga_info);

-- 
2.43.0

