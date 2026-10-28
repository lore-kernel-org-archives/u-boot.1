Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3C606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WBMJ11la;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jHqm3ZT1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79F7580CF0;
	Wed, 28 Oct 2026 05:50:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KUvpoXKBZbS8; Wed, 28 Oct 2026 05:50:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C787A80C97
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166615;
	b=jvLq42IYlSciuOhtoY1Enh9O0kbU5kluMabBKuJjszzljMlYdVtih8KuMzVnuR3hQbJk
	 UXcdGkY9V46tpEeGKHxp7doUwmeSDOoO/a7kJUxqmZ1Agj/2cvrK7ZQKfe5jq+dF/Xpob
	 xdNAliWjSzpPOEZ+ZSpYG5XNVPg0YAd7UsRGNwVnk/W6ydDbR8zstvsOOXWYE9O/jyZCS
	 qoPI1gEKhMjf3qBttjCujkLo/e6oxpH0ujhCQ5Rg6oB4Vx+rvDeaGCh0KVNNmQGEWB9uz
	 zPYBDMZ/hqTGN7GOyqcS77Fp6sQy2EqNYLBQKVAt2BeQz99NCvcD7d+jD+Llb5dTgjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166615;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8WxJZMzFVqzuhmOPIcDVphEvpTBuzC+brrYN0xjB9xg=;
	b=oYSSEcaLuc65biqndujYjvOM5boz7wflCu8pezO8HOWfU6OfMwNQkZErQRhtRFpnjiuG
	 VF0zVQdBIVC7QTWO457qMZZsCmzA1hiDbyavFrdaYy/+qUk6HhWLMJDXpKrbiX+dXL4mp
	 +UWJvEWFfuGcfz/qZzOcL/i7bLP6OFGEllbiuXEd95hX5sbIQRJZfe07DnhfuB9hf1iJ7
	 L4TMZEedL+U7bJlgjqR3gsv7uxe1Af4LRDnkJzRkiS83ADn0s2WInArODoX4UvOcI31jN
	 QCYSLfbAL7ZlBrtNH3c/eVLROxheRsSU2CriNPIDABDChj756MPNSKenIeq/88wGPJw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166614;
	bh=8WxJZMzFVqzuhmOPIcDVphEvpTBuzC+brrYN0xjB9xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WBMJ11laT85j6nxsviMSQOeY/dLj7VT4S+k4t9pzuAoYKYG+TndOHtq1Dl/DWyJJQ
	 I24tMZBnTO2twCUMnA1LGJXtTwvGc17JnjAHcWqdQsB4Sc49rhxSDZqt0jKJbB1PVw
	 wodAisTfa1AdMv7PhwydlcaTuS/h1AVEdWzqEu/AcpWoYAMlYodCdMF+Jycloo0WCi
	 iGboSrLAhC/Xykdcu2tCXhbDY+ObL15uMlXk7vm/SmXFXkJWgKIgLHzegm8Hwo6lmy
	 uQ6y4UVMbzSKTtnGTM4PLgLRILMRB+14fHNhMQWIMSgTPrYoeXAcvOFo7580VTrALQ
	 6cClvuujWTEBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C787A80C97;
	Wed, 28 Oct 2026 05:50:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 47A8AD1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 363A640576
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OfIozQiH5A58 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:50:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E653F40574
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166613;
 b=C9OGoHhwA2XCkOqhHdQhL6+6613WSVgkhCTVtxVIqVvjV5GCzj1hsyfU3M4G5/IgBqDW
 s2jU+no0SFWOHCeDsFdmcDuINEo1rxSxblsVYLbxc0EWzlJuh0aVqvntkqoxKvsvT+0S2
 On3AXpKT4YjtyOvZGQeqQ7sEvPklu4tkLU6Yyjhku9Wz3gmgXbkEZYziXqoZvquVrcW7M
 fp7BWYX+gNTm1HSLSjR3VndzUDcuJ6MkOgWlvgncOilwS6zOMYtpubqHG4VmK3oPEP+Jz
 ZhjN9CdvPEzxJtTJXS0S11D8jqCmk04fgKngMJJY/KPyArbi9bYEpxghDS95jqx+HLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166613;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=8WxJZMzFVqzuhmOPIcDVphEvpTBuzC+brrYN0xjB9xg=;
 b=C49Fi5DII1nON7cQeMVUy41+6OHXofpTQxPWK45zRythclFFi6mE5DKCalaiWrtMXNaW
 fo2rwTzzN65vFsOVjF/659stQX/vLStCaEHTvH2GQvfxrE9iRNBGEt5OAkre9C3WuPqwp
 NNGomgKeZoar58kseaNArKXDRCnIXrzYoSygJtzvlLYiaQ4Rq55ator4o7QgQnxPB9QlH
 U9H1EbIC+4kVVnoVzHA3W+OhetNq9qpV+h0gnv1tHJrZppqYpHtDH81WL++GZcd7KctH1
 94WW7YdLIKVnwm38hBxPElA6ZEuPQW3p58FGddE4VF5RugTHCvF7F90sI3n5V2dpN3Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=jHqm3ZT1; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=jHqm3ZT1
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E653F40574
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:10 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso365875f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166608; x=1793771408;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8WxJZMzFVqzuhmOPIcDVphEvpTBuzC+brrYN0xjB9xg=;
 b=jHqm3ZT14Qz93YdU6C6BjO5+3mmne4jFpYsk8MWs6XgkxU53l7TIVXPcoJL9QuhCKX
 uO6GyzU/71HvzUavhMWTQe/1mLfq8WKasPjvmPLKz1pLcciAm9EBJYB+3/ig28lu+6aP
 MOHYTmvh+V9yq/cgWvSxj9Ubj6uitlsi4juqI9br+jrlI+q3Tuh739pi8FJbDUyFGJ/L
 MhHAZ2BnzptqJ1VscYMofV/fTCZLqVdcaMHSAoqVJ2CQS/ZUfGmuWhai22KQr+c3Kt7G
 SkJyAPRc4KLMPAFk/IbDdnZPSaWdeqHtJ777Gg/WpQvRMqO9/DlEAaEYFHJ4TzjR76oJ
 NgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166608; x=1793771408;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8WxJZMzFVqzuhmOPIcDVphEvpTBuzC+brrYN0xjB9xg=;
 b=ULa//xtHBIEmYy5fIq/VRtvvl+MSMpa8vQ/xUvKS8JL75pvnnEu1cDlCGXSppVRGmp
 4eTy+bffNsg8BjhubaJVbUuHvdl8R+Oq3d2rUyI+YjoHPAV9tBXjJWOMVGUnnl8uthSE
 MzaJC06eXuITBPcUl9UAgiseuRWkgi2AABIfyOcGqbQWmZBtnh+VPY5DJeM1gNj9HGUN
 ZJNR/08I7Ux+PcKOuP814fV0MGtpYn2fPAXtxNLTJhX3mSfurpsNo3BW40OVL2aJrW/O
 dRzAveXBBYbEVLDJ3ybq/t9j30fgw6k3649d4picW/yS4I8rhel1K00MFUIpNSUp1hb7
 YRPA==
X-Gm-Message-State: AFq9FYIN/cUUQ7d3BhQvZAEGquadbwrNFBbI+3xAK0Gnqna0Ui/VqPRA
 fqoRnq8o+KhjDRNXXH0m9dZX0Ja4qK5TVd6DHtp4oZ9bSc16MzbLG5GqhX0KLb9zR5w=
X-Gm-Gg: AYBFou36NhXy6hFz012+wok0cP3voNzSgxmUetmjcxcPvNxZ8ep4BFf4AM/J549/U//
 eJJTKHVEYc0gOslcIXAJupW0/e17L6T1FXVE4PXfXswp0745ANEvHgVPpyQfCHnNYxCgKFCL7Mi
 aZwyLw0bvyNa/8iwrWAML0lq8koGdEXYqbotqlEnT6fxhzGq6xP0CzOTqDlH8OybwsfsqD3X527
 fnMrEFSehynCDpw3oa1NdX2nZlC2ea+ZlTE8xrshbETd/Y7rrtHeAcFRGy6CdMXKOWTOSqsoVzV
 DEB22mfBTvpAf0w4IV8u6Qg7HMoIzgsIDk53+MfDp79t+lomhJOfzqbEBpJr40UyddAuprsla0s
 hn6Xd9BwNPHiOUUuZ7kl0PXwuu4yUB4LSQgklwMeioBdD3kJYkU14eM5xN/c8oOV8vSA57Girne
 4qQhhGgmwTyAWjj0sDSIczA/ZtwBTWJB7to33lKOJkouA30GqQEb3cqVh2Q3ag8mFXPFjt0Hqek
 N0izEy6hMe+zwR/gq/yKaf6Y3IgJuZXlzMYpOrOuQUGETo47rVC+QYZ2dYyzxOTh6fAq+2+jEhz
 UDLaK5NXsoPXm8YUOCAgI3jf4ijfaPc=
X-Received: by 2002:a5d:64c8:0:b0:48e:5df2:a011 with SMTP id
 ffacd0b85a97d-48e5df2a094mr2669443f8f.5.1793166608457; 
 Tue, 27 Oct 2026 22:50:08 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f37csm21440505f8f.8.2026.10.27.22.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:50:08 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/7] efi_loader: capsule: check the certificate length of
 an image
Date: Wed, 28 Oct 2026 05:50:07 +0000
Message-ID: <f8cc0827-166e-4bc5-89fa-2d160faf025c@gmail.com>
In-Reply-To: <ab256ba2-8572-4cda-b7da-45b2c0368beb@gmail.com>
References: <ab256ba2-8572-4cda-b7da-45b2c0368beb@gmail.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
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
index f57a7e60a5d..646428c7d8f 100644
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
