Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AC4606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 06:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aPHnltG4;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DAIGR+Ni
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4935440AAE;
	Fri, 30 Oct 2026 06:14:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LT_z0y4khvQy; Fri, 30 Oct 2026 06:14:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 89222406EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793340863;
	b=ZTjZcQDSs1xcpoI/qGTHsDqTTte6CtdC4PYr6DxOmhKEVNz24GWkY5ByHtNw2RBykGf+
	 h9W8dWhEct9+2hZtLLIj0apRPHMP/5eQFkStsPXQZIQFdeTMN7J8U2IvBms4Mhk4qMQxz
	 pk46uwGHaV5ORvCoMwOgknPk/1LSzZNXD34LHzl6syz/7GHxqPc8q+O8+uwkFsc9u6b+r
	 9zhyIdcW/AlBWHNQljRd3jUf3gi2VXsEse58XbBctzcCzUZV672BaonGvBd/jkwmF5hhN
	 abbAiwmkQHGtW3hrLhkEa897GUMIOQnYFoaTgTnyamX81e8+9wGyB2OqLETDO/+pulQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793340863;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+tnpqg3SPvxq7fL5x+5BplTPafc1mIgDvYpO4GIZVLY=;
	b=QhQ8kbZ0NS2xbjOF3Fk4VK+IhcQEKaWgkFjaVMq+FWhOHK5pLJeHlYRpLVT85UkbtvA6
	 6t1cKkH+5YkhpvJyNyI5AmR5BWvjesjsJ5sYN+fsMc61MVlCJl0+tKiGS3uaa/0k40/sa
	 9Pje98bytnmtHdkKai2esmqFFKieDyy03wx6P3lggN/g7hBkZm1QiXnOq2MZQMeX4vn92
	 GEDlExSoNZzJaSe+MhVqTOVw/ncYnG33EWozmFAwyygX3xrGUyM9RoDs9+A7ZWlgO/5t1
	 Wp9wjtS/DghRIAOJEz4ROSNewSU8EqjP0ystDE3d9AN+mYGAV9ritaYlQoGwkDIh2Fg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793340863;
	bh=+tnpqg3SPvxq7fL5x+5BplTPafc1mIgDvYpO4GIZVLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aPHnltG4NLo1VBeiGKuC+OzglGu3HbM63PoCin3APUuMetkM1lRjijtkvLbCRK8Zm
	 Tsg+7HmGWT8D4FjYFSau31/LrTX5QZO5yCcykQcMeqw1JSEl0hWLAxeLDs2wR3kPKw
	 6Q8bAVKEgXsZPf42d8Dl91AOnc5XiMwqImimym3zYJ1kx0bt+vWVZGOr1YVeZwL7hF
	 hXwKUism9lKsz11XSQIhIzNU6Ciy6nGamy8268RZ5XyP/yBt54Am2eUSGGlJn6HfhM
	 nyEva/aV5h+KHfOdIuJ0OBrpGcli+vXlrnUi76YmxId7Ei8vs5SqoPoaMZOf+6nODp
	 lmt6GIAachW+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89222406EE;
	Fri, 30 Oct 2026 06:14:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AF749362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9220A60ABF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hvKaxi5sPgQz for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 06:14:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ABA8560AA8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793340862;
 b=aeSQYa34K5vtM3gXJe8v8cSJ1/YR+1E7Bto4URUdBSuNmrbNqqCvKgP5kH5zOzeR6HeI
 9gaoZOUJGUgpXGdUIajiisyCdO8Zd0H2T0TnxenH32kqkOmbkeLVQYNfSFUXSLR1Ijt+N
 9YVFCtM70SRWXIt2sOq5JZHzUw1wJf6OdcbIPsZT3IYmpSUijvTpLM26KDtoxxKJOD+SO
 ob9P2p60zs6iw19eAug7LjTVdctIYj0+pbYM27HvROMgAU8kRwObGQ/o8t/cJdFBtG+6R
 vmJCfDQdPuGYrrH6EXQcVIf/cQtiUpzGFgeXZLSvj1CNTj28Wv+VNCwz5XURen9wPnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793340862;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=+tnpqg3SPvxq7fL5x+5BplTPafc1mIgDvYpO4GIZVLY=;
 b=miHuVyygukEubgluGZhYN8LNKS4eaLNCyIqCAPqclaHvHPAJNK2RrSwrmPyJ8daeOOCA
 lW+E1VpzAk8y757NFvVWaOj9Bim/ivr/YkLWgFeQi0pfq/9Od5H4hbJSvsLKIum8hQjiS
 txLHQ1yJo6vLxmklVk1sxv0Dy+UPy50SRR6GsuE5HGVZqXN1sUYlWidlQYvyL9fO0GK94
 vnl0H6/K7N6IRTnSJ1Ku5Yi6BpmfnL233kklJdfnrRDqokZHeoLuhn1W95c/8OYGPgyHm
 lh+FKfdyScVlstGi4kTiHTYyv8M9DIXNGH4KJ9ajuuJAWyvIq5FeOzLZ7foRPDxnS4A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=DAIGR+Ni; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=DAIGR+Ni
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABA8560AA8
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:21 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso1679065e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793340859; x=1793945659;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+tnpqg3SPvxq7fL5x+5BplTPafc1mIgDvYpO4GIZVLY=;
 b=DAIGR+NiCXxCXqEf6s0J8FeZVWWHLKrs4t63Ds333XKrg0zsnPpMuoESnFRF6UrmJA
 wEq42dOwuI5UkTyApPFwTnGLIG0WoRnM2v9DExJKbGpeR4SN43PkD2LTHfW2ku0KYO49
 ADz/2a6rLeCRxrAfMlI2H3LDGigtFs5MzKxo8g28q1K6SXJ0u+Sh7LqeoqmZnFfQAxkM
 4NapSvmBOe1mXxF25ap2BaE/U/fAZoVjLMLK8fZ7WFDi2SRINV2GCAAOhodtzBOQKOqp
 41zo4R4zPHHNnTnp6BtW9h23xTct/oJ3V8mlSO07w2Hn5lJtW4aXXO9ppRmZlelFvIGA
 HKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793340859; x=1793945659;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+tnpqg3SPvxq7fL5x+5BplTPafc1mIgDvYpO4GIZVLY=;
 b=d+rat/A+h6hrA/2SFURC40obTND1IuP93ZQNnIL8SdA3SlPqGTjnQzT/QJWwDzeXCH
 K4BTqfBWGtn8L3b1D/Y1jIfAVyhKl3/I/A4nRUKjFaWq+lHownzCR3tdBcqEbcZnYOOZ
 +l1yA/KrHqsK/lV8GejCmu1NtA0G4C5A95ofKjL7OTz1Rc9HMJjw7rslhzm+0nF5RTPs
 6na6eEmpxJXSpWTGAX7xpRuL7rQMk9uIPLUcoftILAEo6XyeSvAtWlBUeNJY9tQKBP/B
 c+8dlr1hq1/E51s8Y+4wWTauLUlWl4V7J43Kso/ybRIloVNUuvH+2OdXA+g5yxqlqnEe
 oxTg==
X-Gm-Message-State: AFq9FYJDaicwmlGCORSGCrT84HDZQvAZ8JWGivVCr4FsoeSJLhwv52SO
 Alr7Bcfg2Eth/n5tFBfQwMxcKDymgwd6dQW3dkKELZOtn8EQ8OP4V1A8qQ1SgXaqOjk=
X-Gm-Gg: AYBFou1Fh9L9VGnP+8wT8Jy3HUT4mfPRe0tOWqSKpPnDGN+iiqxNGInKsoHDNcuXNGH
 QXKR4opD5tkAb8XLYmCCkHsZiw6urqLJOK2pieTgiKhTZmMePNpeq/wCEDkNYWrgevLy3sKXqy9
 6iNMDClxGP6l8OFjifG2AYooa6cDtSOJHLn5dm6NBLV7YgsP8mz7sNgtQmwum8/c3J4ihhIxVxC
 jccq3H+aFVZLd3K+JIItJeTamJebHV7fMA9wPBgWGiEvxkR/sv/o1Ibxir2qInp8giQrYzqtl46
 79G+I7HGcnE9sSZpdIsAJQe3A85Z6cmyzJVhYRrnLWLlvHTe0QtwpA+VoRltGSN5YCYpFesiRis
 NhgdhFg/WT0rbd4M7+zoAD1aOQ0siTeBCNh3/AEql96IaOW2MC30NWr4wUuQI44MoocBxsBUNpv
 ulRh7oSTKPVN41DIGZODGp1E4RejZGM6DopmtkrO1TdG44ocB4vgeLNoU/+8MwGhcxM0+zKvjX6
 GLqdJTwVGoKSTwB7yNp0Xzb7NFe+nu8Jv0F6SgCIO+jxUJp/eAHXy14BtxX8fAvZbLoOifo2qJV
 XEOkvnS2cxuxJGw1GrNqjSgoKzC9IVmbHAn+dQznaHNhdMGKb6Wt
X-Received: by 2002:a05:600c:3f0a:b0:4a3:7344:13b4 with SMTP id
 5b1f17b1804b1-4ac1709a2d0mr23876525e9.14.1793340859360; 
 Thu, 29 Oct 2026 23:14:19 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf60f1114sm36587875e9.7.2026.10.29.23.14.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 23:14:18 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/10] efi_loader: check certificate lengths in
 efi_image_authenticate()
Date: Fri, 30 Oct 2026 06:14:17 +0000
Message-ID: <b8755d2a-6344-4c73-be56-4e2c366b6d5c@gmail.com>
In-Reply-To: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_image_authenticate() walks the certificate table of an image by
dwLength, rounded up to a multiple of 8, without checking it:

- a dwLength of 0, or one that wraps around to 0 when rounded up,
  does not advance the walk, so U-Boot hangs on such an image;
- a dwLength larger than the rest of the table makes
  pkcs7_parse_message() read past the end of the table and of the
  image.

As EDK2's DxeImageVerificationLib does, reject an image whose
certificate table holds a certificate shorter than its header or
longer than the rest of the table.

Fixes: 4540dabdcaca ("efi_loader: image_loader: support image authentication")
Fixes: 1a44b7059c18 ("efi_loader: image_loader: add a check against certificate type of authenticode")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_image_loader.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index c0677b440e8..c4f64f102e8 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -822,10 +822,27 @@ static bool efi_image_authenticate(void *efi, size_t efi_size)
 	for (wincert = wincerts, wincerts_end = (u8 *)wincerts + wincerts_len;
 	     (u8 *)wincert < wincerts_end;
 	     wincert = (WIN_CERTIFICATE *)
-			((u8 *)wincert + ALIGN(wincert->dwLength, 8))) {
-		if ((u8 *)wincert + sizeof(*wincert) >= wincerts_end)
+			((u8 *)wincert + ALIGN((size_t)wincert->dwLength, 8))) {
+		size_t remaining = wincerts_end - (u8 *)wincert;
+
+		if (sizeof(*wincert) >= remaining)
 			break;
 
+		/*
+		 * dwLength includes the WIN_CERTIFICATE header. A shorter one
+		 * would not advance the walk, and one longer than the rest of
+		 * the certificate table would make the signature run past its
+		 * end. Like EDK2, reject an image with such a corrupted
+		 * certificate table.
+		 */
+		if (wincert->dwLength < sizeof(*wincert) ||
+		    wincert->dwLength > remaining) {
+			log_err("Invalid certificate length: %u\n",
+				wincert->dwLength);
+			ret = false;
+			goto out;
+		}
+
 		if (wincert->dwLength <= sizeof(*wincert)) {
 			log_debug("dwLength too small: %u < %zu\n",
 				  wincert->dwLength, sizeof(*wincert));
