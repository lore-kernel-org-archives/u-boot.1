Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782A9606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ii4qePT4;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=htqP0GS+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4298181285;
	Thu, 22 Oct 2026 14:39:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qOnCvDg_jxaB; Thu, 22 Oct 2026 14:39:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 240668126B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792679972;
	b=ZKP3+2xIhE6snwRuq5gyXxbku4mTaYaLjwcAG3fsalbkxB/oL9RBKdKl9kQMVvbihS7y
	 FegFIwB7EYKdmmafYG62ltDzO5UJVxo0eQefaMbpua3F0gJsZMVmfZb9CmhDlySKYVMHw
	 6XTkM1O+mU9t9sQn6GYPI2WBwnCDxZo3n4tK5JyaeRpf8eOVkWueYTD9I5tXYE83vHr5l
	 LSyjZuuYYuAFZqJdqprSRVj7r/cqBFG5uqLaYCq4slTcsN5zxk85ddm0xoOL+h1V9u6rI
	 2TwmR1SO/Sg+zxuNzbeHrFF5lZd7LZ1m/MyawcCAjpuBYevuLTRM8eu+t6faAOGxRnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792679972;
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
	bh=ZYXxgS8PZ1OMYos2Of3+JxMeU2SpKWnvRAacYRWLGR4=;
	b=KyWiPT4mZV3Llng0l9R+pm09KXODH4jwY6KMQaKkjODXrZ14h/wsRNULpI7dzCY3CHDC
	 p66PBv9x804EFwHYt+kyk+v0MYBtUZsnKR6opz4P5L/LunjoxRTdNaND9UCvP6dy/ZI1F
	 oYybcA8Wz/4isUM+x8BvVNAZhFIGXxE9p1/mwqwsIa4GHWItvhShC3Aor5sJdIbdqsoae
	 bWGaB+pAd7eoovZcJr5Xz1jctD3UjpiYOwrC/1aDfw7yRlG/SmmijlTgpyKfGesjpSjPQ
	 U/oJfCffT//A9JkZS71rzOYBO994jbUHedBfUjK7+sA1+IarLPy9tLdAp3kOxKBgsXg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792679972;
	bh=ZYXxgS8PZ1OMYos2Of3+JxMeU2SpKWnvRAacYRWLGR4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ii4qePT4/lUEnmTD41dxy86lkzaFshgvOCnAUmpNYMtjc45FnHMvNEbRWIaB/r+GQ
	 DKHJLjr3Fejwic6mfYizzvs3XpE5EIF76MytlC1HyO5uLAaAIA6g7VN8gY51ue5/tf
	 U5L5SFLL8d5ieRIA0Oc38XkIGQHAGD658AFNICwLDmA900f2f2F9h6QUh/llzz0UqT
	 mbUS9FIX8zvdSjfwLoekb9Ukl9qI8+Ewsd752STacsCSOfSqJAoO+SBZ1SP909D3uY
	 kfxsVhvaPEuiQFfaS1rjhgQvioYjzrwtdW7t74LZic1BtAPKsXPPd6RNa6C6v9g7Qy
	 1ayR3vw0C9CCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 240668126B;
	Thu, 22 Oct 2026 14:39:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 42DC93AF
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34A6260681
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:39:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 200D-Cp9y24v for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 14:39:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4443A6066C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792679964;
 b=jC1ngJRWUUHEGks2BrI0TZ9/Wfn8hEKcbqzU5wYw+M0tEWv+NlQ+/0uJ+p6umWABGX4w
 9+XjOAw0nf4TR9dm63tllbBdpyAsRaf746NawVMi5+311uSEqMHfQrQsfizTagzpzeNrv
 dJZWG2xaSP4F1o8+x3xc4NrWMOA2XRZRzQlN2GziqOiA9nmYlbmxK+DA9522p6CsdMYuY
 f7lBjQ5ZMOpoFK3Yeh6fsW/Z3dvvF+3w48YNtAx58GQCbSis5/WbvOf+PuLgKQGQ7rHe1
 hvCBKQjSJPD2LvQYUOba/WyKrd9jCDsr/rq4E6hWR4SE2HUlttkc+zc2hHYTKBsIGKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792679964;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=ZYXxgS8PZ1OMYos2Of3+JxMeU2SpKWnvRAacYRWLGR4=;
 b=hQBuljTbCqMXuUvExcGx4zUzPlNN+hJ4lreO7RBYvD6VJDkAtE66Hkd6DGt8mk0NcGL1
 I5Af0uzTHrOonjeMuY1quFWnZChjAkmwaLvkpoxEoCnr0ZIMG1F/B2la1lh7BWikDMkcJ
 QLok0R+sBtU8jL8Cpf2SCx2/Bsd9kfUqUH6J4j7INptGOl2Nk82SYDSPH87t8feoAJcbz
 5zld5d+6UEQIrWF5aEANoEyRQc4sTZmTYEUyrXicgj84ujDUBfvw8ipI/o7ckmen9FzxU
 IGzt9xsfZQDtY5k+zvtfuvU8A8niPxihgUOvgmxq1T2k7o0FU4Won0TfU1zex+HDKWA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=htqP0GS+; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=htqP0GS+
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4443A6066C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:39:23 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so1195150f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792679962; x=1793284762;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZYXxgS8PZ1OMYos2Of3+JxMeU2SpKWnvRAacYRWLGR4=;
 b=htqP0GS+0CU1/2T3LImqtPt1xfx0IoNEKoXESOSvy7yVKyK/zB+NGKdxRpR22lnmv1
 rjGjtLmGomuHYBmkmByAkNzbDTZppDODho8BO0uE6P/vhobZadLfLa+jl/JZpvPmgzoq
 SVR6OUrYpDz+gxsLQAQc09vrwyRqLdMTwWmQX3jD46EPp+iayV1yfosxIOUXzpqYa9Iu
 qUaVo3m2bUr8+ufBmmzYZljvWVsNqN7xk4P+jU3RU4qqPjdVbmhITKSODVELCOFro+Vg
 wE+qyyuFqwuRuoHCK0hywq5bJY/Ttz6rsaKPgCchVLkvsQQF0GeDauCsDH+Y09VZGFd3
 qmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792679962; x=1793284762;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZYXxgS8PZ1OMYos2Of3+JxMeU2SpKWnvRAacYRWLGR4=;
 b=EhoiLXBIz+wdWYb9HmT8ApC+wfAceuWJbAeLELStF1XiTV24fUMl15EFV/Ir7UQj9X
 JZZ5x9/J5wf3ZV+cnDyxjiXLaMSAuXjtQF+KJNbG2S2ZrdBgRkPG6ANZg36yRwr4Byln
 Y09+4+80wSQAAFeVzVIXOkCrv/mKovuqLHpsljL1rhc0x924j+kM6yeIb5PQBYUMSVSC
 iraKwai7+26IK8pYJknPIdzl0/rqK61MgbomIfABU7SmE1/kqk3/lvSxM1Om0oAwTsDH
 XmPT4Qom5CLjMF+WpXqLXIiBm1GVHrFN/hz8S9QDZENjnirRtrqYDMNA1IXpDKk6//5Y
 KY7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxK0K3zf7h5BLt9XcA+0KTUBmwPH0Dgl3Gl31+fIewRlOb4XHzeHUmr+qMAVVhLmcr+DOhOJmw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYITAMWVyZ9eHN6+UAm5oMwKOGQ+3cbRgyRYYIlPXUE03i5pwyQB
 IZEoHk26EJ8wJ4/qAdHOWG/xP443vN1MmVDdRnGP4NNTf3+r3xfy3YmWrBrgYv1rue0=
X-Gm-Gg: AYBFou04iQz8arQaiRwhJ/NF6TcHSpQVikrmPf47TNKbdQtjuOe/pJ4JriGl3N/gNVm
 RfkuQ+fF/qwRicuaGBU/DJ4Q97ix3SYkwYoLn2X3jrT5EeG5nWFlAzlOFB4lYQV0ZZ1rQ//TWgb
 R9xad2kUty3l+3HRaqkCeH2Gahrk1P7oSlhRNHCJkxpAVmjSfSErp0TQ0DNoeNiqnj1vBACpcZ5
 7dWBcRVkqEWHHU2pXH7ZtQs3ePsLDRkRVUNHu4bwdwiMKtL1bfg4uV1rrC93BU0FctX4jOY4sBr
 py9P9e0q/9pvKhNFrdBV45KWD8eBqSbasKfBCopT5e9YRR3eE6HogqCDToXvJsTtIGOVXQbJOYr
 BAX88iWP1X22uaGFuwSOR4qig9otwsVJTdG6t4A6WF9DQMbT8pIU3gAQ+p3Vlu02uPAzXJixx6Y
 MJKGuGdsq5MvxIxE5SfYbgBLyp62jMebT15RBEjJoOqaDBLX7sYi3yH49gx9vvlAnLDE27EwUY4
 jbaZARSVvc/GtRu9Fqd0SvDxrm1PH6wS9EJhJbAYaD2KLjO5B+t/qSHRRYC4e4ZA4e8T6Z33BiZ
 PA==
X-Received: by 2002:a05:6000:26cb:b0:48e:10a7:438 with SMTP id
 ffacd0b85a97d-48e264c2b7dmr10512614f8f.36.1792679961698; 
 Thu, 22 Oct 2026 07:39:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e3bsm12415852f8f.31.2026.10.22.07.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 07:39:21 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 5/5] doc: android/avb2: document the root key
 provisioning and lock state
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Jan Kehren <jan.kehren@emteria.com>
In-Reply-To: <20261020-upstream-avb_lock_unlock_b4-v3-5-e280795a98cc@oss.qualcomm.com>
References: <20261020-upstream-avb_lock_unlock_b4-v3-0-e280795a98cc@oss.qualcomm.com>
 <20261020-upstream-avb_lock_unlock_b4-v3-5-e280795a98cc@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 16:39:12 +0200
Message-Id: <179267995217.3508122.5639649182775410192.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679958; l=934;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=QqZJ8H4hDgYVLzlY3Ekgw8NDKcGoCFYt/VFNKSpOTsw=;
 b=4jMuTxCG8r4eNO0L/IktWKV95XdiAGp4uQXL+TrQcVxVITtc+ePcYE3iL8/TJPWPfxYhpHpR0
 JbwTQx5GmIDCvC5LO5JvIacS/mXVl2VSSCN2JnBWBFS48iV3WfdiyHm
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

On Tue, 20 Oct 2026 17:38:12 +0200, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
> index 43d5600d2d7a..e1eb5b15f11c 100644
> --- a/doc/android/avb2.rst
> +++ b/doc/android/avb2.rst
> @@ -85,6 +85,68 @@ Note that device lock state and rollback protection are only enforced when
> [ ... skip 58 lines ... ]
> +refused; ``flashing unlock`` is the only way to change its partitions.
> +``get_unlock_ability`` reports the "OEM unlocking" developer setting Android
> +keeps in the last byte of the frp partition on the fastboot flash device:
> +``flashing unlock`` is refused unless that setting is enabled. A device
> +without an frp partition (or a flash back end without a partition table) can
> +always be unlocked.

link to question on patch 4 , if new version dont forgot to update it if
it's needed.

-- 
Guillaume La Roque <glaroque@baylibre.com>
