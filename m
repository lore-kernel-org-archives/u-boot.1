Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E41606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Uya5ioYo;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=eiWkbI7w
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5ECC80DBB;
	Tue, 20 Oct 2026 10:34:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Avy7O62tGJ_J; Tue, 20 Oct 2026 10:34:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E472B80D56
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792492449;
	b=OWN6F3kqQ5/Ml1RhvTTQBGJpwKyEe21jeN5FH5ChjK2NmcrcfydXRqJU1gzj88vDCUh9
	 J7ZX6jPVHjgBOnQvkL2q9S/IYlRqdEfteLm2sO9Q6zk+mw9UDsKep7v2eVuqNosq0Dlrq
	 XqC5bbv2NG8q1vgch4VOK6IMs+prX4m1Y3fd3i0TuKsdle6LS8RNs4h7qg/CLmuI2GEdz
	 yImcXdcZKb61C2DFAy9BtZ75dzctBhAwsNy5l+2OhCnbsScu2pZDHnI/qAz5f+SGsCeAG
	 oTt33y0/MQfjBIQ6I7WWxYq0DtWiSgVHsmDyq6bJhuccTlXEwmbIuWu1n4rlZk7JLpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792492449;
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
	bh=TtNEODKQUZVWWWTVie07Wz7abhsBmvioPb/IvaQWQgs=;
	b=qJc03J53q6HyWDIJ3fulpWw/5KMrQ0z11nqPmpSgeN52Srcux9FAlBojgHUR2J63uksD
	 2M2n7sjAQ2jQ2Ma3zba/M4n0yc8ET5y9gR1ekAthLCBhmTW3suwH6sT3lHU56/QoJ0l4A
	 uWOGYWJ7IR4sgs4+erY54WfC9rJjvRutW3XtzwSlq6tLWPWhcI77QwzrMBuYmD+cTJv6h
	 S7EF2wmuP1cXyWrzf1sGhiRy8r3ePF+8BhyUhflq9EgRbiqo+NRLBXH1xR6V9g1RBntLq
	 1/+2p8Xcin/3sxNlxbqDwpAGlKXrm7XK5Lolb6fHLe2jtJf+qU6bYuYSMrNbI1XJeBA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792492449;
	bh=TtNEODKQUZVWWWTVie07Wz7abhsBmvioPb/IvaQWQgs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uya5ioYouRICeHJJh0ZP4X6GqvRsROV8o0tWMJ3qETP8GQIgHt7HtsYiwwGP3HTc9
	 zQ8rv4lEZA3glX3z2M3tvzk90SXfZEJA4AWgNDgpAknDRIuEh9Y2eS+sAgFB04PIw1
	 8/Odi/L4Hxl7/XK8CxXn6ZZn835sxQygfVtb9imPKNOjgrF+/FtgALqqTtxEwbXOl5
	 kii9tQfM3XkMkJuQ+Xk/leQ/4KZBPmFObQZZegGiyXm+5M9/UcS9NH5/7EPCd4qzLR
	 4fEmJaLsUJSsAO7wJwZUPqkOL81fG/Cz+kan06hUBo5KalPPZK7uPexuA5aekYBGMk
	 y/baNk/0Ggkiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E472B80D56;
	Tue, 20 Oct 2026 10:34:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B6471465
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A56A46083C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:34:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LAWyCs0Fhu7i for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:34:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 01A466075B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792492446;
 b=niocoWQnNXH5juqsUdQ+dknwUhuihhMsRuquc19He0Mn1byMOK8VkZsNe0/aK8k0FkQZ
 sLOhGnxZKnsmSQLpyDv4ooa2tOa/J8aSAJ//J67XsblYKSfK6r571zPDJf4Jvd7+0VtmK
 oRN3U54B4ByI+0dkLk8VJJwQ9bdwJrTE4WukJTVar3BpDK4cYhzpYfPzfGeGXDX1jTbSB
 sofQLrAhDjUwUqLUQmRa+81CPV29a9qmEVSnDrEvVAOoCAv6pfpIc7BS/u+CUp8nt/d0j
 AzzO9EraE596n5RKgU9CnZotafIIVLsoE0p1zc6lPmKYUjB/BaH1WdJdqy+9AM9rEqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792492446;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=TtNEODKQUZVWWWTVie07Wz7abhsBmvioPb/IvaQWQgs=;
 b=rXSn+cP58PiXmQOTX71WUtk9ASxb8MvFZNd/7TUIKoK1A9BjTq3nDMnGZjNcjRVp/F/+
 H0WpUeOlWp3BEr0stcynSKq1dDqD97xUrtjYj616vpaTSNwzznuuam/KwUggvGF4dAI9O
 8nXszNtSlYKuQRH0+OD4xyqZfrKbnkJENqfVBAfqbiqvCNLjaN14z/akuOakP+GePhAow
 Jw8/s5cVBYOOqrlttD0OzD7RSCHecFUCvxgRGVUOkWGv5Z4A0NkrJjoXtAmf/vjOyZw7u
 hYqRrWTN5nP4RWr1mUqg8ezyUwhkzeNi0rnhelE0IPkHtpnFYTGpPDSW3ua+y3oDDrg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=eiWkbI7w; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=eiWkbI7w
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 01A466075B
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:34:02 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so3657465e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 03:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792492441; x=1793097241;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TtNEODKQUZVWWWTVie07Wz7abhsBmvioPb/IvaQWQgs=;
 b=eiWkbI7wyqYQII94uLvXuENK5Sc2tVJzf0U4pJ3/zgbe4FRyPvtjTWzC8swDWRpSCY
 vZMCsnKkaImuauIoA3FKTLH/tPZi+Q7LRtpLnLEwrHhtBTPzQYqpRybpp2VutlC8PuP1
 IULsfLWRd5J7ZaaerkCZmPGVsXzEKHc2eR+zADlzA+QRKYoi9JkxxY3E2r41BwleLQfE
 yZx5Jkg89vNOrnpvqaNd9PH0bC2U8yhMf4edc++B1sScR6HMcnMEPjU0WYqTJo8agsTt
 fgKK/h8U4zO7moPjHSjmt3/TW2GdMODU+WnfNfFs9HMd7n8xMU0vMkCvx7ROAEFmLdLf
 Q9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792492441; x=1793097241;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TtNEODKQUZVWWWTVie07Wz7abhsBmvioPb/IvaQWQgs=;
 b=XEBz3KKjeAJn54QdzBAaAZ+JVhqtsgWDX5rCx2RPrSBo2pwQJdYfUo1MCAnz2Xu29r
 onMSF2tiwnO6EjZynfejrWw5KiGp3E+cSMk/xSdfw+5ro4o+HFbY/R1d66Qg8pzK5XU/
 DgAieaknuX7NAlSzj4oVxinlkiYi6qHmIUGlrbm0p1IWIH5wKYvzGkOiXhdO63E+D4NO
 D6+bPJldMUVBkSCTk8jWgresGLxVblBY+RZfEM7CVghH3jWQbrUz4H6CDWYt8w6aLV0K
 2xz+9YmYIQlV3Y4A8do/JVeMUQWq4AEwKI8v5kDpnNW2RPRTXjJyDXGhfyFg1InHy5mY
 hnBA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaVQ5CgDBu37dkW5iyWfBPVjwhI/tsomqne8aJJXHChLfJr8q0/05wpOJsQP9BIRmypAxZHA8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI5Zri0cfCM7yB5iw0ir+dljhd2D0KskUPwmMeZ/qurLNqZLaWr
 hfWaKFAyFQZtguTUC8yZQ0NXia2WuuSmZPewdjlSKSzXrYt3ZcVTVgYw1qZNU6Mg4a1/qWRxVMx
 nNZPB
X-Gm-Gg: AYBFou1GTE82c4BbLUss1vt0ZvXgVwlMWFQnrlCtOvMn09adhYw8kYXQng1EWYJkgZN
 XtSDwII7n9BkCBy3y50zSaCPW9NspY9KnUSfSKeujT494jjyhCMun3n6QnH/5Z9XJotKpX0Tusl
 e+rZ55jTDNQbbU+X3THQJG7EK8ySkE2NrrWWVnCvuVKh7iqhS3KgKN+wxpmaFFzQK/7pZIleKhx
 w2CcAtwDLl7Q7Br03E53RKFSS+TeiJOEb+Ge01p41xcnHynDBHPXfghMvW5gMy6O6FVFmqzT2zs
 FY0I33NR+R3BKFkRzCkrxJP6Wj76vvB/7cqYsTHEZlvWfGiBZ63CE8UP6XXd7omRDvUhBl3nbXt
 Q9Moqj3Kfe10F7w6l5OyFPTGvKCdcGrKGs3Q8pHr93bo0XOXF+qjbV31QSpFDODxOYjf1APbmxU
 /2U3NMWXgbxFZ6442KpTIXqpTTag5iTlNmn2Tdbtx76imPvvtO0b+bL7aNIYjaX0Bs7e6jciqVd
 RcSgzkyECU6BJLXw6Kd
X-Received: by 2002:a05:600d:644d:10b0:4a1:9c71:9f17 with SMTP id
 5b1f17b1804b1-4a1f4e7d46cmr26887375e9.9.1792492440900; 
 Tue, 20 Oct 2026 03:34:00 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cdc342sm67880245e9.13.2026.10.20.03.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:34:00 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/5] cmd: avb: add read_pvalue_hex/write_pvalue_hex
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20261012-upstream-avb_lock_unlock_b4-v2-1-87460a24e559@oss.qualcomm.com>
References: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
 <20261012-upstream-avb_lock_unlock_b4-v2-1-87460a24e559@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:33:56 +0200
Message-Id: <179249243656.2829155.14652655226584959128.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792492440; l=534;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=u9CYh7FIhqCvp6bFitjJWss8s6QjsB4otnqNcGY0+pk=;
 b=D0LKpLgkof9kJTzt7hUWhImpxFceguTWsRDpMMgO/6kPnGPdvcih//G+nSRJGyPP3H9SsNtse
 e0McEscfq6oCQywqMVSOBq4HI/whUNZ+H9ob1POSdnYu5OwlMbGhHFD
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026 22:25:03 +0200, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> write_pvalue stores its argument as a NUL-terminated string, which cannot
> carry binary data such as the 32-byte SHA-256 root key digest consumed by
> CONFIG_AVB_ROOT_KEY_TEE (persistent value avb.root_pub_digest). Add
> hex-string variants to provision and dump raw persistent values from the
> U-Boot shell.
> 
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
