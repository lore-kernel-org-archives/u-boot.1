Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CB5C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 16:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8B8140791;
	Mon, 17 Aug 2026 16:29:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A8xHgKQh3lgL; Mon, 17 Aug 2026 16:29:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A310406AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786984180;
	bh=3bQERKUGoUdoV4ifXGck5yNyj6oZWl7ylkSfYf94WbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mR8zNfE57px2v7oZRzIsaU4pvsIoZrC4hdd3qFOf/uO8TcGgvLnNnByPD07Le2u9s
	 d0fmSlBFcIa5T/ht7v7jmsufALHUr+f6XfRH2R0JXPoApil4KzsTQsjatgyFbfSmCy
	 B4VRXG3IQBpUOWDnHdrqv0xxFNRXW7MsXjqu4cISKsEjgdSJRFhya1GEFI1gx1GWn+
	 BntVtm5hxsMQdSI3P4fbdmpe9SFw+vd5jYFP2OjXGN9bBBYLIakhe7tS0ZfLVf4tTa
	 5vJ5mMSNbcIsnjeFbdAufwapLZswZMcqXvDdR6oUElZKafKW4gzSRtPUgvma2asWyJ
	 iM/AQfWw9C6WQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A310406AB;
	Mon, 17 Aug 2026 16:29:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AB2A2334
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C878401E5
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:29:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BHKM4gxRcV91 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 16:29:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4ECBC40130
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4ECBC40130
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=DFmGb4fU
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4ECBC40130
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:29:37 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso46291425e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786984175; x=1787588975;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3bQERKUGoUdoV4ifXGck5yNyj6oZWl7ylkSfYf94WbQ=;
 b=DFmGb4fUraH2SV0CNfpYcuRWbtO0EEgI6S1r8p+YzGbUDp2cHhI0A4zIJ6wVw3T8o9
 +66yz6GxUsQgxRKIQpGqUiZXcSuToC2UdptHO01GRNFCZnlyaiuwbDqOJRLP8KQ2/p2d
 ytlez0yZUH9Xh8K70yESoHBr0fvi91erw9Kt4NExJR+WwxVkFHkEYLRKijc/5aJtKMTU
 ZFjDytNJxBfYAX7z5F6h5lD8LCRmYtSL0EHTdRO9IPFHRCn/Oif5rGuLdnpoqhh0WKhI
 5kWAxlbetGbRhyt9dUUss+HiLHzC2W3BuBfRJKjaUHn3HNrj9y5hzMEqJ+YC5SBT+Hgr
 txFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786984175; x=1787588975;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3bQERKUGoUdoV4ifXGck5yNyj6oZWl7ylkSfYf94WbQ=;
 b=Ns2KIUVdKmoLuWyTHIdGlBvE5J6hdhtMaV6bXAiTjHB+/Z00JEUKJ4n8jDFuNL0pvZ
 Fgp4ffHDV14AdABV4t7BpBPeLzh6iHzMNmvwvq5q04j1sKCBC0GL0Hzxmk/TTrWRdJyG
 aqEizw1kmmS+/i1JtAK1Bz+T6jwOkd0NFNoS/ez4Djp67RozVwTkxAsFnfpL2sI8Cm/M
 ip8Eybp1QWiXPgIuHy46LbUKhgfnrtoZAkCxyQQ7IEJBK1OskTLg1vCsoeOzH75FH7ES
 h6qLOfAdBnlIr+M60RKH2hIgKxpeE65A94FwA0u/ak2+pCVG8bBb1JM94Bl7BaTq0CNo
 A06g==
X-Gm-Message-State: AOJu0YxGGZfTidxfQ7Y2OyjE+KrxYFiv+Z3mlRINQOCoIvXCEQB2B+m7
 5RnhIEt8kYRp2joOWlMQicsPtXqakUXFw2auY2RDVzaA/lQ7twGXj/nfk9rbiQ1fOPaf2mS4BnG
 Tnebxk8A=
X-Gm-Gg: AR+sD11ua7c1qDICn8/R/HjIMaU9ixRPkwJ0U/Q5lOWFMsJ8b4P4gNS7EkVtaSkrVh2
 GyTh6G8q1YIhnh7JZJmcrBEoiN4G9PODpgQkg6Za1aFeZTsXLL+Tt+4O42sAFKyHkCODg0mkber
 UpcSUETMTN4AR4XimTj4yWKS7g+z2HSw6mMylMulxgAOJvJoBqca9NsP+DarBks35p4aCMZd7V1
 E8tH4MTLSRMzAISubj2di9fh6/3ckIJUzVHhmKVPO0P30fw2SjG5zqNDUQWkEETBJ2xXUX/dPjq
 xffqoMFe1we2zKZToW9qTNa3v+QGvwOiGasPjBMwPHqN3s0vlsX3USjeGtfZs9wbb3URNjTdAWN
 fawR4xvXlzz8WIXBtDwzpvQTuZnkNXPE8zFs3/jsoWZhEDFSm5IQGypg+zb+vQ02IEb8sdoSFlV
 3ors5qGWYPSD8O5ZJAyFjtqtn7Wy/tpU3/CsmH/2mF6BMUEK9GT4HaxBFDMDJ3ORVgky3VUCnE
X-Received: by 2002:a05:600c:6088:b0:499:7219:122f with SMTP id
 5b1f17b1804b1-4998792adf6mr480872685e9.4.1786984175251; 
 Mon, 17 Aug 2026 09:29:35 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:7281:1989:ca4f:c9c9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998ac6afe7sm181109795e9.3.2026.08.17.09.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 09:29:34 -0700 (PDT)
Date: Mon, 17 Aug 2026 18:29:33 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v2 6/8] configs: stemmy: Boot EFI from external SD card
Message-ID: <aoM27XUGDQKPlnWe@linaro.org>
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
 <20260817-ux500-external-sdcard-v2-6-ca9a110bd9c6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-ux500-external-sdcard-v2-6-ca9a110bd9c6@kernel.org>
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

On Mon, Aug 17, 2026 at 11:31:55AM +0200, Linus Walleij wrote:
> Replace the fastboot-only command with standard bootflow scanning and
> enable the EFI loader so the removable SD card can provide the default
> ARM EFI executable. Filesystem probing is handled by the standard boot
> framework and does not require the FAT command.
> 
> Disable mkeficapsule because generating capsule tools is unrelated to
> running EFI payloads and adds a host GnuTLS build dependency.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>

I think it would be nice to keep Fastboot as a fallback, e.g. when a
button is pressed during boot. Some people may want that for updating
U-Boot itself.

I had this mapped to the Volume Down button in my original change:
https://github.com/stericsson-mainline/u-boot/commit/3a499aabe598004da889c507095edf8d9b21244e

Nowdays it's a bit easier to do this without extra C code using
button_cmd, see e.g.
https://git.u-boot-project.org/u-boot/u-boot/-/commit/359e1d4a57e06ab662ca7e008e881da27e9d3562

Thanks,
Stephan
