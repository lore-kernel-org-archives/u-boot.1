Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65C3C88E45
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 02:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A40060601;
	Sat, 12 Sep 2026 02:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hsA91GAAePB3; Sat, 12 Sep 2026 02:13:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B3BFD6060E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789179227;
	b=Bd5nnugF5UzT1lIW6STZHHPFsCacBSun2K9kjkfCsEAYaOZ5cKg0fdIKe5GCqGLHpmu4
	 uMJenwCHg347d6KheMK5uNlCIyGUKkM7Rz0wPBAkqGutvigw4Kd7Xn5nCA9HRCVhEcZUY
	 hB3n575CCBlUyHnxCzIvdSYY275VBJHN4pqNDcO/zodZkwCMKX3C5wOem/2UzATJdILMN
	 4My96OQ7YklSKhgdd5RuEe67fPHL14yL/wXx4ZzszmZy0GTZzfvzTmPyVODV5iWVb9ZFg
	 kqrb+rZfpghs5X6qKftrEmSJ3XfeyTezApT8q4cd/Hi5uWOTXLGA8YNS3qEcsVVesTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789179227;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=n8xn9S4o7xYocLOIeCZuAJzNjxykftHM63RPhT9zljQ=;
	b=FUsq6jhxUuTJ9BHILXg4vFZ6gsDoQt5qB5ttcV6XOYvqFxikWBbddg2DnkFTOIx/lj76
	 xM8+XhZSLnXLKfzTpXOHaOYbDE6HBnmpVyC8wJz+VBPgbvDONumtWzyhSt6XttJTAaOK6
	 RlHctzwh57UDyx/kZc3PZsZRJu5rkBmx2TX1Jtr3sCI/U1F6L/JyodVdvf3fjaRTxWB1t
	 G2ZyBPSQKCinVibu+mYeoVJIJYBGEkG9rO/+eEBIkBRk0VPj8PY6+GHJRnyxdlEuyA/8W
	 Wgvo7Vcx8dqchNBNxKDWnqYOKSH/KYprGhMCZ5vgx3jWdhbUW+EiXy/jrp19QBP1q3g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=jasg60gu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789179227;
	bh=n8xn9S4o7xYocLOIeCZuAJzNjxykftHM63RPhT9zljQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z83NZr6BhQQvAtCV/dyvuceCyuAK7SftSmfjjocXzxAY2Av9DvIc29xBTRur3l9rC
	 UJ8Fh24BSK497NNOIPslcCD3bujecxiTLQrogA8YoWDIUstfpS9C1eP7RgkE3SCIEJ
	 u4T/TFh32x8LfHqCc4fJRToK6I58KxU5WUDZkrZ/hK4etD9nfA5m/BELSqiBgoqzEE
	 1CJKCm23o+xvnhToyj4BlUi36QvK+YWZp1NHdWCUmpH7walC81LVoYJrKUqbr6lh0+
	 7JXA/mDh7kqjFQ7D7ipMs80k08S1pAxa5m5dzLBqs21Vy17rCXGIKvTaRgDDKDXl4C
	 3LtfKpABU09sA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3BFD6060E;
	Sat, 12 Sep 2026 02:13:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A5132E3
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 02:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3BEAE6060E
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 02:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Z7YrixMsp1x for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 02:13:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 598E560601
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789179225;
 b=aBGzkQgs0EGQs9xgwEtwlvifZJ/g51FWo7lzrNAfG1HAW40MvkdXBhEKBXvPp1dLGW0/
 a9zyLY7Jne9AnYiiiR3vXIhIlSq5KcgKooUCVnR0+4S8Z30cUFzH9Jn55aGbuDPrsg4ia
 iSfyoXFNwgijUV+km1eesuWVac+vvEDE2ee3ZeARLynvmHSZq/sCqxLV4kT/GfjS16eNO
 E/nazEFdgkmGnzhRoqM0GZ3Ag1jve5yklk0ETgNZRaNqqp8Mmba2YxUxMRBHREE2awH/O
 LWFbWZ1D8b7Qg5yU3mUunrExsSCyu3m2zENXAExxrY1GY2gL0qD6TOHac56qgW3dimQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789179225;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=n8xn9S4o7xYocLOIeCZuAJzNjxykftHM63RPhT9zljQ=;
 b=S6Fk6C/iKosDQ1A9MFSJpImS5WCWQIk4Tjf2lUg0zFbpL3gbGJJpPAoVKAjHal/AC/Fb
 KnS6FVkLo8OPAd1qLI2bPxD/+xNItr7LzkyUwRSPeaRDz6ycyCAuz+Kt2q+w1TB3hrYkw
 09d7ynfV4N/4D8uHQ/tYWteL5o82eA7ku8XE69PHNw4WL/O+WWvlY61gVk9yGKllwzoaF
 zpyx5u8Uy7bn0/mGDKj9jYQ1a8fJzE9EgSraMqDZRXlTy0yVXUwx0Q/0ZN6acUxAADIXS
 pbIP+4Se2Ku9l71XOomeT+H8iehXxKjnnJob+y43PvcUtp58KzedNMu9MAg8xrIorsQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jasg60gu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::10; helo=mail-oi2-x10.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jasg60gu
Received: from mail-oi2-x10.google.com (mail-oi2-x10.google.com
 [IPv6:2607:f8b0:4864:32::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 598E560601
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 02:13:44 +0000 (UTC)
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4b37a30eac5so363482b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 19:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789179224; x=1789784024;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n8xn9S4o7xYocLOIeCZuAJzNjxykftHM63RPhT9zljQ=;
 b=jasg60guk75S3Fqe2AjN7Yhm1ItmBW9vEo/xGxNj622hfCEWpWVH9alx/G3vwYPTUC
 S+4z+x6paltAlujiLOH9HPoDCoEgEKmeyX/EzUtbGSkxZM2xgyHk66zBmufrjlhsrRVd
 xomNPpd7h+Hp/zSdZW3d7HxRhWiA/1DcfPf6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789179224; x=1789784024;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n8xn9S4o7xYocLOIeCZuAJzNjxykftHM63RPhT9zljQ=;
 b=Urk/HZn2MHjTR2XjC+h0lhWQ5RVkG1GCgnq4tKoY7S8OIc6gVrpu33/bwcgqd2ok3N
 wHs7r6JC0iHa1PGy2df0EQV4eC6uf8mG1YOfSV9dul2060vk1uQCIKhIbnk1xNGyNoE4
 /MXcUie+qZoT+83jRX7u3CERPA/Z46TYzIKMlVH8f5wTOJvMdIV5N+ZFICiLKxp1FRKK
 XJdXw3/oP62K8KokuBNzs74N894cc+p/IRS3FP66ynKJRqx7yPTjNHXQCujOF0pqPCxy
 pSaQbRgLshrCpJpvvPUFptcdFh6Epb47UrWIPr3YMImaHl88GMoSiYw/2BcEBqfxEz8J
 R2Mg==
X-Gm-Message-State: AFuF++mOqG6oyCj9MVbOXW92v5T0KRuaifassUeYTY5H4z8Uzya6tSbF
 bpeCrotQVMeLiO0WHECiDUgL7DqUQbtCc0y3F8vGyCBi/fsbD3j7v4O5RbRGaw3zqn4=
X-Gm-Gg: AYBFou1A1u4PxtyFiuJyVDxDWq5YIh2sTns/BjCwl/HkbsPaxPbYDxmTdmYZYHnBw7L
 9lR+l+h1IJaU21Qjhh295C5nk21eOFx7vW5+jN77j9Bf65Md8pwJ4xXaNrjJ//ye2V3kBvjrBMO
 2DlvV8u/oInrTGPqChYYo2T6P6JfXiqbFFG9+FKlWkfWUUTNFiU0Ncl97ac75cWtPxd9ZkofK+9
 xobvzTxNU4vHF56jYeS2ybMUBbzmJZ55YQ8RKOAeVl7laTGx4pxo0GjuuTCOhBrWBtSPjb0ud9h
 B08kmr/Nxv/0zlEq8mG3vdfHWlOMVQwN5Xsh4+XEMeBk5IwFrBYElRGOP9XA38mDqHyRx27tHCM
 wunnhHpCezX980TS30c1ya5hr1NxSRyNz1esu1Q0eNi4d4D2eWym7Pd58YoPTQTEB2azHSj9JU9
 kAcSkEOemVH4fcQIZ10oDVF3aubex6/AZwSsKqbrWhNJGzknN4B2uMGF6WzxAn9WavjRkgUJQ0z
 f2uk1NaG6Gas+lDOs5aPl04agx+yyH7+Z0Q4tddYuU+AL3c+cd69u3xNM+xE22fUzGaJex/0Xul
 SM7TN5mUSoKkdxVCA+A=
X-Received: by 2002:a05:6809:344:20b0:4c3:6d05:18b2 with SMTP id
 5614622812f47-4c36d051ba9mr7018553b6e.21.1789179223667; 
 Fri, 11 Sep 2026 19:13:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c3321eac1bsm3978539b6e.15.2026.09.11.19.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 19:13:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Pranav Rajendran <pranavkasthuri@gmail.com>
Cc: sjg@chromium.org, philippe.reynes@softathome.com
In-Reply-To: <20260825141953.9534-1-pranavkasthuri@gmail.com>
References: <20260815220754.11724-1-pranavkasthuri@gmail.com>
 <20260825141953.9534-1-pranavkasthuri@gmail.com>
Subject: Re: [PATCH v2 0/5] fit: cipher: bounds checks on the ciphered
 image path
Message-Id: <178917922229.3882172.11616409287280914047.b4-ty@konsulko.com>
Date: Fri, 11 Sep 2026 20:13:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 25 Aug 2026 15:19:48 +0100, Pranav Rajendran wrote:

> Changes in v2:
> - Kept patches 1-3 as separate changes per Simon's request (distinct
>   Fixes: targets, easier to back-port independently).
> - Patch 2: documented the new -EINVAL return in the kernel-doc block,
>   per Simon's review comment.
> - Added patch 5: a fit_cipher sandbox test suite covering all three
>   defects (non-block-aligned 'data', a truncated
>   'data-size-unciphered', and an oversized unciphered size), per
>   Simon's request for regression tests since these are security fixes.
> - Added patch 4 as a prerequisite for patch 5: <u-boot/aes.h> defines
>   the disabled-config cipher stubs with external linkage, so a second
>   translation unit including it (the new test file) failed to link
>   until those stubs were made static inline. Found while writing the
>   test, not previously reported.
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] lib: aes: reject a ciphertext length that is not a whole number of blocks
      commit: 38363ac783de606798c273175e9fa746651e5e06
[2/5] image-fit: check the length of the data-size-unciphered property
      commit: c2b8eefd4e108b7fee67eccb08a345668a29d677
[3/5] lib: aes: reject an unciphered size larger than the ciphertext
      commit: 2dde840a70f91fb184ecb6b997a8203f6c6f91ad
[4/5] include: u-boot: aes: make disabled cipher stubs static inline
      commit: 4dc05884af34f75ac3a66f2f2ef4dd662cecfb97
[5/5] test: boot: add regression tests for the FIT cipher bounds checks
      commit: 973a05bb1b1677a9ab7ecfe3807b82582039ff6f
-- 
Tom


