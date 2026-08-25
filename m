Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A402C61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 12:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55A8C606E0;
	Tue, 25 Aug 2026 12:53:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HqwR_uqLuDXl; Tue, 25 Aug 2026 12:52:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787662379;
	bh=OCvV16IwM2byZxhPSWQczEkfoNh3yQI2lrMJXdIAuqE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QuY5gkWXjZMcMwEK8qggZv6rCOsTBzCMvPU05ryFNfPleksQNyDkI9yDzu2eCfuHi
	 HRLBJ0kgsGZGt7bXXxy7twFqcOSvoLXH09p7pFPEHlVEnCUMNVzecMP9KanOMu9NPg
	 SGoD1n/rJkdx8acPgaekdAXxGR6HxEjXUD58AznSdjkkSIIx7JggGwlJiuBCuQf4r0
	 cNbhvo1Bj23xLpzMGCaxwnoi7OuyfHaxkdiCY5YzYltv2b8LvqCkpWIgr8+zTPhEE6
	 QWZNFEejYfjHojBtHZV4T/FywBw2pqP0pMiFb1mM8oHkgBBBAXMZ38R//SQvGEkeuQ
	 DjoMOTEOo0XmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 887A5606B4;
	Tue, 25 Aug 2026 12:52:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 039F91CF2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E99E4400D1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:52:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XjVdHPI3qvMp for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 12:52:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Xuo1hiFM
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CB82B40074
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:52:56 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c15cb6f5c12so840301266b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 05:52:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787662374; cv=none;
 d=google.com; s=arc-20260327;
 b=Sjh+zGR4lGBasafvt5SFQ9cRqhtKRNSWv5NtQV9zlqs6WQx77E/NwnALv1IC8FtHs1
 KURQDWgPy/DsqzWttrj2r5Ao2Kd7LqT9oFZ7ZZo6NQ8EBrsnd/S6lyhKuTKyx6dr/5rd
 F+w6XM2ltI0Ymr9dRUwrlydwcVNbcVv3p2JSvN7Y2Jp1J1f5zBgklGdr7t6TirAFwfCr
 40F7pGlGeCSefjMGU9mB8jnZRYWY59dzdNi33cvCZYwj1atMgtwWj5ucpHi4JU+CfiWd
 f9SUOKRtYcZFGC6aO/n3J/IJeWXABbWL/M/zK6RUC5xOXRnHpmJtA9TwU0T766EWfMod
 /QzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OCvV16IwM2byZxhPSWQczEkfoNh3yQI2lrMJXdIAuqE=;
 fh=XzCxGnlMyhrCeKMYiADjLi/2k0me15Xc3uVw3N77990=;
 b=mSQz1Q2ShncMStPdZdB/nzfncsVF8qeKydKu9u4IPZxni3Mo65+k0dP17Vu02EVQqx
 aOEbVfKRVAW7jcB7fGVIZrUHAljUb62pNadDJJ+4T5wi7QaxrJuY8/CXQ/IJxfKtGq6D
 7zlXWvCv2srCmLDrZnQ1k7H1shb2iTLiP6HeSdfCIsB3LMc+9y1X4ZOkB8OWMumhjPf8
 RGnAlnAm5neVDBvrcK6P+ZBYVwj/GKlAfrZvRP6lFLwaPrFfEDlODDJzZopCV6HnhgOU
 SC3oMYcvuqYy57h8a1g07aAAXpx7XDrE3S2AbvxzHFH2PacfObclWvWJRZR9SjExpz/c
 BDVQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787662374; x=1788267174;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OCvV16IwM2byZxhPSWQczEkfoNh3yQI2lrMJXdIAuqE=;
 b=Xuo1hiFMRVh1/q35i4VRUUbp4e+PNIsbLq0zoobEJ3Ul91Q3Qc6N2Ls09pTat/vv/j
 ylJjNZwp7P2wAOuc9yNb+ek1J/ADBtuGL8aTeuKbBwRYQyVgotydjBr3pC6M/PpbkrjZ
 iTKXxTCLLtpFiW9AYP6d5hGk3AEay3+WDQ5tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787662374; x=1788267174;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OCvV16IwM2byZxhPSWQczEkfoNh3yQI2lrMJXdIAuqE=;
 b=HuIA4530MYhXwM7rP4QNRrNQmT9T34/YGi/cVQutwnYoNPiuMKR5yS81Kabc9a2HxE
 wEnTjnqE1He7BHU00uR+VE+tzzqS0XZfmnuqxog7xTpkJ7xdL7Uf0rDhcz8XN2IjR8WK
 Z3pwPuqMLIMX6o8tv1JiHT+T712kLaOedfv9YOHmg6o8IkK4vLPJu/7mB3DAkrk/ipK4
 3jYF6JDepqz+yUpn4B8NlMMQA+e4Ty9//ORabbhdKLb/zoV1pPl0Pg1wegz/E3ZZyfzr
 Pzyf7gBMf/fNRACqUSHjF2DXWt1d+amcsZZVJvFCeQkkMtzVeobY7pwvJA75lh4NoN/e
 1gvA==
X-Gm-Message-State: AFuF++meMtdtkQvA9W4/2Cjnlco8lVmXG7kl84dF+53NWAh5KCh8A9b8
 u77kEWnOxF+TXYwHsdzDrIZ6N84w3qaJ+JpGm3VMZjhijd8Q+rCGjO0iMmLgc/uQJSILxeICPmm
 vdOoScrhG+2VjjNxio1KGVU0UaAybfc/qISjKDG05
X-Gm-Gg: AR+sD10Y5OlQsPHGvzwF2lnlpX3OMlaHvHZfhvIvECpZHciwoDbDlr7irYs3bpXzTVh
 k+FjuEqoj3YAjDQ+V1XbGyMoZZcf23OUAUM34BoEfApbIPY4JvPEFMr7owIuJSPR+lNYs5UvSBX
 Bq0ya5qRTjZKLCEUE7FqQTLG3m8NzCGtGK0DGF0ElV66kNcbij7zH0xRjXubq8xqCBzFCrhNyBl
 vobKu0J/GtoJx+Kri12DJi1KKBwP4ElJSMVSba0kM81nrhkgA8w79VGB5fZNkgbKPPYbnn+21IY
 LGcjdrswDwrYAm/BsmrwZ+scwCGup87HFpXFEACs7SUk
X-Received: by 2002:a17:906:6a10:b0:c16:2dc0:e1ef with SMTP id
 a640c23a62f3a-c24925e38femr2652999366b.14.1787662374119; Tue, 25 Aug 2026
 05:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260815220754.11724-1-pranavkasthuri@gmail.com>
 <20260815220754.11724-4-pranavkasthuri@gmail.com>
In-Reply-To: <20260815220754.11724-4-pranavkasthuri@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Aug 2026 06:52:40 -0600
X-Gm-Features: AcwNN1Xw-gJpcRBDPdHZ31OqaXRXMOOBRap_lUN13Um7JbByhKB7C_fzg7q6SqM
Message-ID: <CAFLszTgaj7d_bypF=ihdVxeVo+ZS45dsMx26DBsPKs9=agDA1w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] lib: aes: reject an unciphered size larger than
 the ciphertext
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
> lib: aes: reject an unciphered size larger than the ciphertext
>
> image_aes_decrypt() allocates cipher_len bytes, decrypts into them, and
> then reports the plaintext length to its caller as
> info->size_unciphered, without relating the two. size_unciphered comes
> from the image's 'data-size-unciphered' property, so an image can claim
> a plaintext larger than the buffer that was allocated for it.
>
> fit_image_uncipher() propagates that length as the image size, and
> everything downstream - the load, the copy to the entry point - works
> from it, reading up to 4 GiB past the end of the decrypted buffer.
>
> Unlike the image data itself, 'data-size-unciphered' is not covered by
> the per-image hash or signature, so this is reachable on a signed FIT
> whose signature still verifies.
>
> Decryption produces exactly cipher_len bytes, so require the claimed
> size to fit within that.
>
> Fixes: 4df3578119b0 ("u-boot: fit: add support to decrypt fit with aes")
> Signed-off-by: Pranav Rajendran <pranavkasthuri@gmail.com>
>
> lib/aes/aes-decrypt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
