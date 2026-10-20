Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C5C606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Uwd3xeGB;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=osO9gDxE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF87F405D2;
	Tue, 20 Oct 2026 09:48:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vbC-cGAY3g_s; Tue, 20 Oct 2026 09:48:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DF60740815
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792489722;
	b=bhG1Hn9Ce5QFgmu1e15qsUYhPNoUcBj3iWraSHJtaGLZaJttVbVvIjH/0hwzNo3z1pr4
	 93BjDzxroxm0I7c0eDis6v21tegACxP6EpWD/mKsVR7n3W8bYeaK3SAAh83TG4WbdbUqw
	 B8kaFh1DD7MQefVOP/ASv61nQocmG5R30qp3gven3UJVUeIkjfW042yoGqeqy5vMc65yM
	 kymP+HpOLQ1Fe47SjeiP5mc1sRY/xSsGxYrqE98MsD0i+e/etQ3OCJ5ljkv/H4o59sDaH
	 5Shq3Gj5qzhhVvhu0u7bdIcrqQGnQQ+RGcScCBGHsxIPYgF1Y1x6663k06IEYsJ1MoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792489722;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YwbV+H3uunQF8KIHMYSkBIBtWxxh5JGdzvWdMNuJ8Vc=;
	b=rbTGoA+klAl4qPXYZSZ7YlVJRop5PKwUjdQjY1r93ca43cWEBkUk2Cn7q+IkkCNYZqtH
	 v0fNTuIVCvP7NCwIdnGTJemKnXMUKNIJM6J0S3LvZsXyJtUHtlCk3/PVKZW3FmEBywXx6
	 kSnfEKg+5VuxQkpUieRwr+bYQK8HEFcgtKMRSnUKP86/vgeHe1qh4BYa6BAhKR9/V7FOd
	 B7DlqsunJac7ZBlnXZmew+yGeze1MWMwEwJcZbpQbXCqbB4XblcvyOTc37VJ18akQR+Oi
	 71jdKKBh1MhqL9F6JMVn/kd9g+7FDa60s/bi4W2XrtBPnIfoTTY8V2P7CyMc4YJmCBQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792489722;
	bh=YwbV+H3uunQF8KIHMYSkBIBtWxxh5JGdzvWdMNuJ8Vc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uwd3xeGBhCzeSiBTbNzMubfbtGMlE5p8jvah9X078WYuJy9q0bdEwAeC8tzP7yHqo
	 rGs6qXoRrN9FQR7ZoYaj++5KNH21O1sPXmpoppY23bNw1tp0Qarn9k2HhoIIIMr4zK
	 uK8bmyoaH+R6sE7/H+Fv0RD6plcTwpegN7npqBTUMXIeUbzPnkuWPFtxB+pb4Z9QOE
	 mXVG0U0U3KhWTkvVSFNQfBv2fJ4m2M0DAJMsTW2oJDM0aBoVGg40DcUt3EYGKXwkEG
	 KDqGBEEiqMGqSODNWF3ENgWZXtcBssEx6JnM39qi4O9LUg1AU1ruoz0CrWDfOmNGng
	 cvDrOF8kSSvIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF60740815;
	Tue, 20 Oct 2026 09:48:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B0B5723A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9699980AF3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:48:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5n_8JGuo6VZa for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:48:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E721480FFB
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792489720;
 b=TuPujwX7MmIRXjUWVG8g1a/sjAoxYSn3B2T82drFFf3EkYrB5PkFubRg199roJEhiu2Y
 r/kPMaK3Y/4ixHPQdp6kCOrj6aAqVvUhFowDlvY/6GUKIODWOHO1wwe5tiCLt+kdrNprp
 PNuTjqsOykwWkohXGxP0ssoSqMc6eqpyPOT5W//NlruPMq/z44zaeU28E8WKk/9KbHbKF
 YNv9TUCNuo6a/EdKaqn66g1Y3OzdZSIluRPNYIGiTgfUTN6eo6qSVjeFMIjc29tbly51N
 aT5sfZh1b1jaQ7jNv1xG3yVJQo6t7yhbfOBya0QWMis1zwh5fPFQBaAs+rm1ojSLDHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792489720;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=YwbV+H3uunQF8KIHMYSkBIBtWxxh5JGdzvWdMNuJ8Vc=;
 b=nXXTgnIQVzJDs5dTpttSfnMua0e6E/K4RuAcexw8Bz9vBOl/N19pJZn6JNSR2eCI0Gew
 uTizRzCjUZgnTwHMRLvkGXtMuNUokE3Qr4L2CHzHT5gvf44o11fB+Gw2rq+EF9gDzbfvU
 tOdIWhqtoveN0YUpA8DmchAuqG8lxvhj4fa13bZprzqbeR8KXzotEEG08iUSAWL9cbRRk
 fuvCUerXUPmR8nGT/Ql0Pngcopleq7Uq7wut/zDCa3dZ5bfEMx9lFZoP7rHE2r85HFEqI
 uqp3S9jN8GqxYLVLrGQX9ZufaChk/giV7O8pjlN58Rdkef+Q7pXZi/LKBBhSJiw3f0Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=osO9gDxE; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=osO9gDxE
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E721480FFB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:48:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7DF0640868;
 Tue, 20 Oct 2026 09:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15821F000C4;
 Tue, 20 Oct 2026 09:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792489718;
 bh=YwbV+H3uunQF8KIHMYSkBIBtWxxh5JGdzvWdMNuJ8Vc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=osO9gDxEBQwQxO0eZsmTBs4C0ztcfKf+Czexcl4pnAu4ZvOSiQ+BeVj5XnZtMzCav
 sF7rI1DS7avylsqymDrNo6hngX38mgRs5giu9kRhj3FKLc0GSEnbvUwuzWI6FkzPbf
 8kZxE+Zm1zpQKNDSBvkNNdnCcLYZS5ufIROX9y3cqZFvRj0npAm2wBZylk55SL4m8I
 81bE2VL5ikq5RKkho1WxiQtluLxsVM24OWr9RKjnizlXCOF0F7nGmRmpqWd7zE3vJE
 QZOJ47KPbVsAMDOzGhjUZcAzbhJHK6vflJGi6/8HaOAUS5TyDzpR2Zg+r2l3lwiezJ
 uNSA4Q+Fz0wpA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, u-boot@lists.u-boot-project.org, Kongyang
 Liu <seashell11234455@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Tom
 Rini <trini@konsulko.com>, Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 uboot-stm32@st-md-mailman.stormreply.com, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 2/2] usb: gadget: dwc2_udc_otg: wait for mode when
 digital filter is active
In-Reply-To: <20261008-dwc2-iddig-fixes-v1-2-24c302b8953f@foss.st.com>
References: <20261008-dwc2-iddig-fixes-v1-0-24c302b8953f@foss.st.com>
 <20261008-dwc2-iddig-fixes-v1-2-24c302b8953f@foss.st.com>
Date: Tue, 20 Oct 2026 11:48:36 +0200
Message-ID: <xhkdbecdk4s97.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Fabrice,

Thank you for the patch.

On Thu, Oct 08, 2026 at 17:37, Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> When starting the dwc2 core, it may not be seen in the correct mode,
> when the dwc2_core_reset() gets called. This is seen on stm32mp1 upon
> first call to reconfig_usbd(), a warning can be seen:
> - "Waiting for GINTSTS_CURMODE_HOST timeout"
>
> When the core gets initialized, wait for the debounce filters, so the
> correct mode gets read and polled later in dwc2_core_reset().
>
> The routines are added to dwc2_core.c, and inspired by the linux dwc2
> driver.

It looks like this patch is based on linux commit
2938fc63e0c2 ("usb: dwc2: Properly account for the force mode delays")

Can we add it to the commit message? Or please add which linux kernel
version this change is based on.

If you wish, I can edit the commit message when applying. Please let me know.

>
> Fixes: c5d685b8993c ("usb: dwc2: Unify flush and reset logic with v4.20a support")
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

The code looks good, so, with the additional details requested in the
commit message:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

