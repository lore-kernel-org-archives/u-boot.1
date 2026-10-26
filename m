Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B18606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TH1w5uAR;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mnk0FQ31
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00548406E2;
	Mon, 26 Oct 2026 13:19:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TCR1WGBwExAa; Mon, 26 Oct 2026 13:19:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3AF69406AE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793020763;
	b=ezmhb/Q1lzicyjFuRrxbY3rP96F1K/IlV671B5v41I8kTVcVi8xfCIpJEnWdTXpHULcB
	 T9M6oSjObGVthZbHYNJg9tbDV0BaaqWp5U3MlJsAwpMg+th0nfQ7yWyQJGGGdMHNw4Yi2
	 nnT+/cTAdQ8kp4hzmiUrnuPqJ2AzUPkr/okTo3TtzNLlNLqQn86RFIZW+HiDJFqEWQxly
	 Oe7/Y4/ixTs9IPAXw9PA7b/iDlfSjG38MMv8NHjHMPC/Mp3Lzi9r+smZfqd3jLlQS413R
	 PfBvGrPxDXQgtcxmssLnEY0dpIqFRwf/4+w47bKbrNPNUUOKzfkX+GFwAL8+qcabyRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793020763;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=neIe0+WXhp6K77rQ7umk/QztQdkfDsN76CEgpEKDIIk=;
	b=ObEzayCinAxTrZqqqDbW/MSTk8U/7/zpS4F4LRSJb8IHivVsPVgZuZ9uKiUJXGOeMhWU
	 mafrNdcxDxJCov9S/HNjsy4RrdVoAeNyrDDnmJdq2SLS+7kPd/wArDcbVQ6XruHk8d1sJ
	 OCCyxNfoUd+tkIYaXtFvOl7Dh8SoXhmLYfZZJvfg4UV3uy6zySF+U10U2LeN3jw/Y67wd
	 YOTlEE968V/ucUCnpfR1QLfHjEWn+2FIh9mfmVW6UnvAabqmDkBSBMkx35VGljEu6zZb5
	 u670cW1xDfjWUIuuvXf039OLA3szU5U9ywkWdJJAaWHGJczBWRPtefO/xBA7G6CORTg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793020763;
	bh=neIe0+WXhp6K77rQ7umk/QztQdkfDsN76CEgpEKDIIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TH1w5uARyyK40wy/PXKHnX07GrJvOInDXAPYSesuvU71mn+W76dUHYS5EQsgzlfAd
	 3pTBxJCvSvSDK+LAfVHfd9bMutJPInDGSslXsT8FIZO81ck9ymSruFaI6Lv2PDdQ2r
	 q3JdTDnKgc1H4gv+duK34UXXnUrJJ4lUKGa0laNXZGFclgzYYVEzuewpvM4TmRLo8u
	 UW0zXSRhpNaCRMPMm6ljzZV7FpYVyXW4zVmDfYQdJn7cuV40RN6c8Cork+UUs7Jspk
	 FrsnkH17zKfyOvncf3g0pdBcWbIEQMmUDhDmjUBW7ouULuAHAvZXpdG4ThNJgk7RFa
	 I/SjHDaxWbmLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3AF69406AE;
	Mon, 26 Oct 2026 13:19:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D2BF4279
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C484E80D62
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEgrpuGCAFuT for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:19:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D52A880D34
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793020761;
 b=hJgjxY1vdkMhEBcsrACaCZo8ap35xYdc/pd6EaY2CGcwFBW6SGjDRZZQvXjbCxIsqCnN
 Eva5Tru73QrZ0OZPPefGYE5mzvDvCCiPlualfzOK7WtMK3TkXRYDHBCXkettnQR/pT6zw
 ckW3eNpU44RId2Vmy/56oHoaIaBoNyn6m9/xo7LRsA/Xx9EHv9zydvrGNXUgb4LuTG4PX
 Rfr9CaZuiTxzswal/gzmQxVKDjocPyZyw0KOJUayC9kHq51YGhV/AtrFujive/NMSfBVv
 dtYb3E5lvu3C8rnz5sv5xlUIYQzEw/2XZwSp2hnCTwR4koJ+IFwQzvTLDAtHI3BgslA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793020761;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=neIe0+WXhp6K77rQ7umk/QztQdkfDsN76CEgpEKDIIk=;
 b=h4Xrw6A7fHaTF/TgUJMNMTQARg6rojjTlGCckNyEbcSymUThLLhjdgHPLx+BDOGG2KW1
 E3H7Gy4poGyTkYzjtoyfPZJzXOMH7bJA7vqrOtgmu2WCrAX2P1BW5zyZg90w3VSLgZt+F
 IFi+oLo8xNtInPTN8rG9tTHkwi6jnk/ZD26O04sVWC0WL6NE/yjeeXFSA3iwWqxeF1Pu1
 Vluv3wrYYabmPXES+g1LSp5h5xDa842iX51pWT4+1R4JGxUwkHkgDj1Ro32PJXklovRDl
 x0IhjWokaTteu6Hw6c04qIdSZVKu+MmOvZYPlQ6o6k5dnHe+UMh7O9+zgSINRw7YrbA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mnk0FQ31; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=mnk0FQ31
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D52A880D34
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:20 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso1745884f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793020758; x=1793625558;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=neIe0+WXhp6K77rQ7umk/QztQdkfDsN76CEgpEKDIIk=;
 b=mnk0FQ31+eb2cSaXjue6OKfps4Pe1BoVDI0N7ILVFC0wLbjxbfQH40IKlVNbxeZawg
 dJDF3KkU5fXwzuJz5LLnnhSwZ/zhQU8Eat/p5NlYTCeTKRAxZRdHRsJFruSggyk24YUN
 aXGbQgiAiMvqoPAgAibw1R5nUj81IRrzxFhsKxIMbPr5wZTJPQV59yulDt1ZxE7U2mZF
 ndp1HrLJc+jcVBd1MQUEaFFHFG0O49ggfU41cZURTpw1g9QpyrZ5Uqj5qJ+eM/s3pUc+
 pWeB4phyhG9/HWQDfwRWKxpZsAbqBqnsbFgbaFLhAc9Dn5+5JSBj1iNl5BtMkgB0l1K1
 8kvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793020758; x=1793625558;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=neIe0+WXhp6K77rQ7umk/QztQdkfDsN76CEgpEKDIIk=;
 b=bx2Fsu84+QGFojB1xmxDUrWRTYO/CaWJ2o38o2EsE9m3gXh2gtJCcpNlPkMj7A34/t
 bjlvG/L4YqHIecPBhfwm+VeiSahik9QrFms03mvF9rkEJKhGXlMQC+8rcIjtAJyTmK3J
 TSlowE61F5sTxaMJK8Dysw+17VEPrYaxCG3q+kRV0A5neRDff+LIR5frXyAVpfE4JEMn
 o0mN6pJP2pcbzGB10+uuEle7xOWN4LNhGyyNCA9Lt7Wj4nHBHJcX/Kijmjd8OC44cTMc
 v2aB2RKBHK7luqr7QkbrQQZ8ZB7XRkfD3L+yaBtiCuBj9IXf4wzAdJP0kooC5svPJcst
 x7mQ==
X-Gm-Message-State: AFq9FYIDpNQGpkxHJ6jOCGeuTawbWEE6xgqZKDWKY7DGW7Ix33uTKhQi
 xE2oM4cbZpHA8kldjX7Eblrd1ltfypACZ1/ZaZ2fpfa4njAnOQ+jeYdmALH4P1Bt
X-Gm-Gg: AYBFou0GI6aOcoX1/sUTuG920Ax0pJtFBkurowxSrqnOWDQEUQMQvXGFUDpbgpVPWOs
 FravZbqCvVWZn95nm8Ppyk0ebTuD8FC8Buv5mWtw5mJ+ooUuGlBD++HP0D+LwtncODGXqZUU0rE
 wX1d4WwXCZSQwnml8z3/yTz8D7KAHXiaV2k2+T++Ws9pCrvVuc4MBQb22bBjZc5ELjIuQwaF0ML
 NJmzwTEtywj8HmOAQ84a4x6dhFSlNPcwY4X3ngf9D3xe+ZYiB3yq1yKTyFKo6TDZN6n3Yill47j
 cfLPFz+jPptoTjUdLan0nbHgC1LNNycz87yeGgwSWcY1leiFnBSdgs6gw8QaJB7aoSry/2giczd
 mSbim9vpR7or9g3DtFCRpOBGMxKS8KbAfXemIPphjP43dM/D/G8x8izAZYqvkxEQhQ7s8lV9AGh
 /e2dpsH5xPRDU7nCyS4uE5NJzIBilEDaJ61qNw+TEi2b78svwCfR9vs5oh9ZZ44GrB7Oqy6Iexs
 pB6I8LQ+pWEl/EaPuMrc/ipsPhok2fhEgxt7sgbd5iUVolvC1tDwvhl0A==
X-Received: by 2002:a5d:610a:0:b0:48d:f9dd:e3b9 with SMTP id
 ffacd0b85a97d-48e3eb8684cmr10029694f8f.17.1793020758302; 
 Mon, 26 Oct 2026 06:19:18 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ece14a1sm16906136f8f.57.2026.10.26.06.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 06:19:18 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH RESEND 4/6] efi_loader: capsule: check the certificate length
 of an image
Date: Mon, 26 Oct 2026 13:19:16 +0000
Message-ID: <8747959b-774e-42fc-a51a-ef78efe21e46@gmail.com>
In-Reply-To: <f58ee8d2-b69f-48a5-99f5-a1bbcd3a920b@gmail.com>
References: <f58ee8d2-b69f-48a5-99f5-a1bbcd3a920b@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_remove_auth_hdr() skips the authentication header of an image by
the dwLength of its certificate without checking it against the image
size. A dwLength larger than the image makes the image size wrap
around:

- with CONFIG_EFI_CAPSULE_AUTHENTICATE, efi_capsule_authenticate()
  then parses dwLength bytes of certificate past the end of the image
  before the signature is checked;
- without it, efi_capsule_update_firmware() passes the wrapped image
  size on to the FMP driver.

Reject a certificate that does not fit in the image.

Fixes: 04be98bd6bcf ("efi: capsule: Add support for uefi capsule authentication")
Fixes: c2cc60c1f93b ("efi_loader: capsule: remove authentication data")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_capsule.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index a8d57630a6f..a3da22aa396 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -270,7 +270,9 @@ static efi_status_t efi_remove_auth_hdr(void **image, efi_uintn_t *image_size)
 		goto out;
 
 	if (auth_hdr->auth_info.hdr.dwLength <=
-	    offsetof(struct win_certificate_uefi_guid, cert_data))
+	    offsetof(struct win_certificate_uefi_guid, cert_data) ||
+	    auth_hdr->auth_info.hdr.dwLength >
+	    *image_size - sizeof(auth_hdr->monotonic_count))
 		goto out;
 
 	*image = (uint8_t *)*image + sizeof(auth_hdr->monotonic_count) +
