Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D046C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 12:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3174E4054C;
	Tue, 25 Aug 2026 12:52:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0UVCxfp7NDsT; Tue, 25 Aug 2026 12:52:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787662358;
	bh=UjtqjTL30DXweLb3TXJTlIgGEetfd/UwtwyG3XUjRj8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V5dszeRyNULTJxsoPsl66Oq/9i8iWvVKBWupWr96DHKtjHVeuxOfFykItiaVQz4mj
	 roFYRX/2R2Tb/+VQxUiYHSTkuhyrzGhepyUSMD18OMbA8+KpSuMpv7Vk27ct7zsJLq
	 AEVeBJUgdB9J4wUkNKLHPYZaBALadtdJYELtOP+XysABNGjyXiRfNAWDLqAUoXDhJ3
	 J77eCMdYS4QREQjgW78mbuAa/QdYWudVeOqwFqYfEVJG3UxEvODtSGSj3QMfr2JmPc
	 ShPGpWwrXK07hv6rhu8OlbGibOTIY6xg+k6EVAO6nLgyMj3PD+iZdcJzPzvldg13zi
	 /M78RIb4v1WIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33E7A40550;
	Tue, 25 Aug 2026 12:52:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 084BB118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:52:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EEE7480C6F
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:52:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tEMPZszpIc-U for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 12:52:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ViSfCvl6
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EF44E8082A
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:52:35 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so541603466b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 05:52:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787662353; cv=none;
 d=google.com; s=arc-20260327;
 b=CrrbpmaoaeFyGIp/cifynf0EHcJKCXyhlGoU5HLArMjvtXLnX4ix1BsHMhgDe0nrqQ
 PghATWtjFnl3JaTckj+1yxloc0JToQc8WQqVJW3ktCqMGbsvT9WxY6bzU0nyN/2wEUFH
 S8Nt+jua1Xl91oa6ZPPo8rFBBJoBWGz+YBDLBHERKzGRHP3akdKbbfpG21seQwZyjl9M
 iUsdPtz2IsDa85BXt9ujaG+cf3DY6TUhxhvqYDa2d6BF4Ki5M6JW9tjNjAZOn/ZC8tt/
 wK60xbyihzmL6AhJULNQlbi5AraSuyH1TKkCQza+WeYhhcuaehfM6MWzE8ZcFot/mdsS
 oVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UjtqjTL30DXweLb3TXJTlIgGEetfd/UwtwyG3XUjRj8=;
 fh=XzCxGnlMyhrCeKMYiADjLi/2k0me15Xc3uVw3N77990=;
 b=IdZ8mcws5pDqK/6Hl8Rf9VfeLECPOhsvr2LM6zFoXap4VVPd/CJ2gVJFzcoBpQwLuD
 Bbyv8Olj1A6arPFexJnb4pKReFJalR9P/GCXYg6f4iOBVyxXG8mNxq+A9nfRPnfDS/9q
 1Luc8FplLl8yx73alKEG4UI3NR+bkq1+UZLPXINv8AHkF+CE3D/awvEMs0x3jCymC9p/
 Pjbj91UePBpavLiMwj9Ish0MtZeLlBGz6jQ5JSdWrETeuUBDdsa2xb3pasLPEzAA6Kdy
 wj9cf83oFxzRFZnv/+LJGic3vUePXJ3GLb0YduXqnG3a4xMAoutc+TIa5h7J82XrA3U5
 5vsA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787662353; x=1788267153;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UjtqjTL30DXweLb3TXJTlIgGEetfd/UwtwyG3XUjRj8=;
 b=ViSfCvl6sh3s8SroAh9g4ZAMoRUBaSZXIhVkmOrSizYbfQ3ix4z2ta75HaMpkGfg1g
 SAw2RmQzaP0ktZJprqkhlTkZT23yJRTm9Ba/oQ/oPb6ZGCrtWK928P8Mh7nWiDDrB0jg
 of8Y9RdhWi64Ybew7/1B4h73C1G5tX/cRnrI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787662353; x=1788267153;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UjtqjTL30DXweLb3TXJTlIgGEetfd/UwtwyG3XUjRj8=;
 b=lmfODTiw1Pfd9S4Zu2XTLSFkYOLX5uQ3vcE1i65YV0vAiGTv1hjjJtnlqj12mhwJKd
 nImyWOCjxZM+yXUaNznJRh/NQtn03vK/wNZHjHtjMqFjazLqXeE2o8Txaubn1u9PLARA
 O0bhyocuiO6ZeV41d6AQFW9SwsgrOitJNnWuJIziXug+XfIRErLXPRKPilZDuNMK7g4R
 u6CGBL+tJN5+w8R0zmgIz+TkaM/iqE44NuNFx8cX/+OxpywdtycwQb0IoMy610TYdqdH
 bDBwbOr6a0N3JWmcc3qdSO29l7LdAvt72pFCJKWRS9d3EdLbvQsSW4BXRZxhTe7ZeSNi
 ayDg==
X-Gm-Message-State: AFuF++lskxblF/sn52WwSVniddk1J+yhQFlwsdrciSSuFwuxyj7ko+gN
 GaqrwhsjW98/Eagw7HlV5Ie9M2x+SH9WJY6nUoh2efE8pY1fIWTYPtge8IK+5e8yBP5RFKTPNMV
 M9duHmg4cJo44TOQ+Hhw9jYQOFit1//tf5aLVrYvnyUd33fYdvFu5mA==
X-Gm-Gg: AR+sD12XxL+dk4in630QE318HLzeMkKrY+BWq+VWGZi5Nru1sTnpmexkG++8DE3GvWi
 p0XVHEVmW913FAsUPXBSmx+HFZvZAlITuMTQTKLcOGlPR7SfUWiiYDiXtIt//iepkXdzpikT9He
 3FTSmUPr4tATGQS8ApgRYDdTtvrBS1ycmbsq7R7S19nx5aNp13SsId60h7H9XT8TspGIQp0j+yc
 qAwISSZ99qYhugpGYeMUrZwIp4LafFwZKh6XYvrlrXiKQnyCIVcUaAGv5xNK86dCZyah49UWl11
 wuEVq9v1zrDsLV20HqSthdGx66cAZ4ZlqssOtKUJRowWfn0MdJMrbQ==
X-Received: by 2002:a17:906:f588:b0:c24:d430:3929 with SMTP id
 a640c23a62f3a-c24e58cfc2amr733867766b.1.1787662353400; Tue, 25 Aug 2026
 05:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260815220754.11724-1-pranavkasthuri@gmail.com>
 <20260815220754.11724-2-pranavkasthuri@gmail.com>
In-Reply-To: <20260815220754.11724-2-pranavkasthuri@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Aug 2026 06:52:19 -0600
X-Gm-Features: AcwNN1U6HZhVSy3f4AHGios6kDWrQ5RIEZa_vLq0UXg2Ido_YOYwGFT_RvSYGT4
Message-ID: <CAFLszTggn90N459-JBXorn7gR=11UoUpWnyQc0pEPtGWdh+p3w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] lib: aes: reject a ciphertext length that is not a
 whole number of blocks
To: pranavkasthuri@gmail.com
Cc: u-boot@lists.u-boot-project.org, philippe.reynes@softathome.com, 
 trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
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

On 2026-08-15T22:07:52, Pranav Rajendran <pranavkasthuri@gmail.com> wrote:
> lib: aes: reject a ciphertext length that is not a whole number of blocks
>
> image_aes_decrypt() allocates cipher_len bytes for the plaintext but
> then asks aes_cbc_decrypt_blocks() to write
> DIV_ROUND_UP(cipher_len, AES_BLOCK_LENGTH) blocks into it. For a
> cipher_len that is not a multiple of AES_BLOCK_LENGTH the rounding up
> adds one block, so the last block is written up to AES_BLOCK_LENGTH - 1
> bytes past the end of the allocation, and read the same distance past
> the end of the ciphertext.
>
> cipher_len is the size of the image data in the FIT, so an image with a
> 'data' property whose length is not block aligned is enough to reach
> this. The overflowing bytes are decryption output, i.e. they depend on
> the key, but the length itself is not covered by anything that would
> stop the image from being parsed this far.
>
> A CBC ciphertext is a whole number of blocks by construction, so treat
> anything else as a malformed image and reject it before allocating.
> With that established, compute the block count with a plain division so
> the buffer size and the write length cannot drift apart again.
>
> Fixes: 4df3578119b0 ("u-boot: fit: add support to decrypt fit with aes")
> Signed-off-by: Pranav Rajendran <pranavkasthuri@gmail.com>
>
> lib/aes/aes-decrypt.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
