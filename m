Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE74606A320
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ijgkHSp6;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=BPIYfJxC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC0C8606CF;
	Wed, 18 Nov 2026 21:23:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kef1k3a1iUhD; Wed, 18 Nov 2026 21:23:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D70FC606C7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795037023;
	b=ga3S3upNwdSExYfrDfLSom+Pzm3cBazyvGuPGY51gHXYQDOCKDVh1LUNoDyDAOhyWmqO
	 Z1Y9i0vSpgOkjAWbz5SkHwTpVSoY7jeXDBFWMNAf973fTrLlPVQrYKEnbKu7tL1V0Fvg3
	 jFgfsnAkNbga0iuPyQlpP25fswH1oc2fB6i81mD7a9N+aOm1qqCMHAIWv7fvcEHjC06EW
	 H5KTVM1jQjE2YS//VahiM6vGifQMlYXp1oh3/qdwZIQEaTuv1BYScQrlpICbW7vsiAyWb
	 y/0qq0LCQWT976ronEAPgr2KjTZ3xp6Y33E3unDgwwNe/S8OORA2XiFoRps5gMOU2Nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795037023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=O4neXXnUslqFiTDggyCl20mjxdptjF41dbKRI7kpVK0=;
	b=IQukOMzWlB3SWIrLdwI6ECpmua/K1hDb6HJwO4dZNaDt0I9XHpFquA37yLWDLPN7pTbi
	 +DH2V446rCMfenpn/N9Ws8TD3qtki6ZWmN7or4vQ9XZntkj7HYWGSEqZuWrRLq8wbTfpP
	 GHOEeKyqjSlQ3g2QIll9Bdb4UVGfIX7pdzmCUizSs0u0ldaHz7sr4WmEK8weDqSqd46CS
	 EhrVdZqytHwsCSuzNd0zdRwagSnbgj7xEOY5HcNcqxjiGEpBym/nqCDCPrTNrS4yVFAJG
	 sn2hDRpMioi5e4B5bbDwiTGqUxWRRSAqFmR4DZtgkLBao1JHjzVEsbNXtZszknYEGrw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795037023;
	bh=O4neXXnUslqFiTDggyCl20mjxdptjF41dbKRI7kpVK0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ijgkHSp63EcV+K4WZOAqQsYibd75RI0YTbnnhN0vyHgZ4LBvAPR5pY6rWeZ+ZGGfb
	 7U97Yn7XaxWTocp1CqwdkmCuaVQD2oaRMjfkkuhwVTp/X/GGgI5E3gSivwRObzkDP9
	 tXwk2I3wEx4JDo9e1ZkzlGEUCsN2ClF1ThA1OvsdPD13fAZuM7luZb4O+ao6Yz2OOd
	 pBhu6Z9ryCRhuOxNp1CipPoArmLKa8UJrxIxXIcXDR7O+6qgRDUG8Z3VJhwPFA8XlT
	 2VQG+2pay/0Dg5By9bQdD3pi0oZ623PE621bghXMhB0Z5R6pLWkfMCzqHlt8TErjmL
	 FyuREI3KQpnJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D70FC606C7;
	Wed, 18 Nov 2026 21:23:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E0EF22B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6083C80C66
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:23:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0xDuxvQoV6vb for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 21:23:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4968480899
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=BPIYfJxC
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4968480899
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:23:36 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4a358881793so797115f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795037015; x=1795641815;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=O4neXXnUslqFiTDggyCl20mjxdptjF41dbKRI7kpVK0=;
 b=BPIYfJxCW1Ee9dPjVDqVuo75A/jWWGXOQWsvFf8kLQ8oYiBqexRGjnoDBvEkZH6i2V
 zemiUUatIE83+Cmvv/h/VuhYdDDsOFvQw/J/KYDNRtJ8YWFySdak6dxdTw4o4Ur3fHfj
 wNdwEdR9ZkKM4eaVJO4cCAvRs/p+2+70eTreIsNTh5bQcVo8c119dXEIExcvEK+pQMwP
 HtDdJBDRfXMvYVJrKmEoc5cAf6m4Om9YIz1gqr1T4CpZc7ZZlkE4XfgBiGo3CK5wg0B1
 h7ys5xDpGoP+d7vYyubmuA4VLzBrQ/Z7tM9xJ0wwp3g/xnKCJ0Sadzg0W94tBTAEIp8N
 9WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795037015; x=1795641815;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O4neXXnUslqFiTDggyCl20mjxdptjF41dbKRI7kpVK0=;
 b=OVAZyF/LlD5XLd0phyPccb6XL3/B7UZjAPdPehx5DAMBET28SUNAKExc+FPGg/4DSP
 gPNkE0toL46kIL+fNq4YXjjWbemDfJMVlbAQt4puc7F5KKFIZ0ZOMXvef9eGIw35DXpQ
 Aur+vRJf/PGuQVqbXcaGcpvPzPk0NPg7VhzIZdKrARdJ7ywakAC3gVz+su9y57hMaYjZ
 SRFnwxfRGSJD+VuhcUlo/AfGXaBxJ/kmnJ7SNFGA71g4m5Rxa4Otu2ZJ3M96mCVS8Pvw
 Gtu4jwkPd8U3DNuqPF2SO7LO8ugHuBsvtz4XbKHNmqXICB6H+Popd90yRK/DRv8+6ElX
 Yvag==
X-Forwarded-Encrypted: i=1;
 AL+hErGmMFsWH2MyMSHb5IA6jt8UAgKnqpuVNmXchVYzgI7szyYwUVMa9BNQQnBD4tx/IcjzU8hGkLg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8njNVf623cR5foTVlmWLsgoi3QLA5jsN7VoVfNVGSjPzH2nqRO
 XN5dv0gHLkfP7tApeTQm1Yk0SUU5nwh5bDmIbkYipv9z0FRvY/SRAmMO02uefHTh6/A=
X-Gm-Gg: AZFdTZfxTMCVwrijgv/CDOHWwCG6B/ohMaDR+nxyui7n3Xf8Ddh9F8z0iaA0dlnfGOm
 5Dc+8d71MlH7s8jb80/CvZEtjTCfLrODxfaG1f+uN3GcVNvD53oX1t97HsP1/cBSekkexzon+lf
 muunfzukHi4+lDUHuLizkpyCQq0MsMiANw4Ync3kuAn4O+qpuDG7htMkgNJe4s0msr4pvqH5AqT
 CdTZ0il90GYumnB7Eb0v4n4o8AYR8DJRr72MouDyfeDOAC1GGI2uV6ZeEE0j2EB4hoQToCrScat
 6WUsVNHIUqLsUZJB8wVX1UXibR32nRDwkYE7PExLLRU35x9O/5eRPoqojroX96NYkhHM4ADRpmK
 tnqICnXoT/ndCTdcdbKRPbQJnhSJbBYZQ+rbEHX99dCOgoa+Ufu99l/VAkdlG6Hoz9eTnZ3il8c
 BbD7+6/sqh5uhHAqtLVWV7VDoI2ptLamxR0UwizZYocTWB/jL8HICqfHPXluC/A21+P9YvZk9DI
 2LGDDDXRAxsRWymFZ6BC5gAf3B7u1k2YgTsH6cQuYAjkX+YgEc1HPTWjrm36iB/gF2yp3SAA3cw
 qpgTO95VU7FwSwgZ41fVNOmZJb/uzh3qGmzLHBYiOTa1ZybgtdIF
X-Received: by 2002:a05:6000:1a8d:b0:4a2:ee0f:4fa3 with SMTP id
 ffacd0b85a97d-4a6346da8e3mr8732094f8f.8.1795037014826; 
 Wed, 18 Nov 2026 13:23:34 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm7383280f8f.9.2026.11.18.13.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 13:23:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] bootstd: android: update the rollback indexes of a
 known-good slot
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261111-upstream-android_rollback_misc_b4-v1-1-47d17e8a5d92@gmail.com>
References: <20261111-upstream-android_rollback_misc_b4-v1-0-47d17e8a5d92@gmail.com>
 <20261111-upstream-android_rollback_misc_b4-v1-1-47d17e8a5d92@gmail.com>
Date: Wed, 18 Nov 2026 22:23:30 +0100
Message-Id: <179503701090.2286122.5730935879872436840.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795037013; l=1752;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=3H7cOkJUhHjQVx72Mu9Fs8FWZLpz8rusdwy3fRFu7lI=;
 b=8aRp/5cVqBtj93YbL0OFfQc+pQlWFjAXBCkrQeKbgPnlvW+Yb5sUoQEQHH+qczWO3rSWgXwF1
 cscDCqeLxJNAfutvgIILdzHLTM374muAJU6YfKlkI3j70aoDtkrabdr
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 10:13:32 +0100, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:

Hi,

Thanks for your patch.

>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 6f7e232d2c3c..3d1e64aa2b41 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -539,6 +572,21 @@ static int run_avb_verification(struct bootflow *bflow)
>  		}
>  	}
>  
> +	/*
> +	 * Rollback protection: libavb only compares the rollback indexes, the
> +	 * bootloader stores them. Raise the stored indexes to those of the
> +	 * verified images once the slot is known good, so that a bad update
> +	 * which never boots cannot lock out the images it replaced.
> +	 */
> +	if (result == AVB_SLOT_VERIFY_RESULT_OK && slot_is_known_good(bflow)) {

Linked to your lock/unlock support (04d89df5c259), this needs an
rollback index than the stored one, the unlocked branch above fails the
boot. This is a false positive, rollback index failures are allowed when
unlocked [1].

[1] https://android.googlesource.com/platform/external/avb/+/refs/tags/android-17.0.0_r1/README.md#recommended-bootflow

>
> diff --git a/include/avb_verify.h b/include/avb_verify.h
> index 2b5b24958ae4..8479e3275593 100644
> --- a/include/avb_verify.h
> +++ b/include/avb_verify.h
> @@ -83,7 +83,23 @@ int avb_ops_add_preloaded(AvbOps *ops, const char *partition, void *addr,
>  			  size_t size, size_t max_size);
>  #ifdef CONFIG_OPTEE_TA_AVB
>  AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked);
> +

not needed

update: when an unlocked device is flashed with images that have a lower

update: when an unlocked device is flashed with images that have a lower

-- 
Guillaume La Roque <glaroque@baylibre.com>
