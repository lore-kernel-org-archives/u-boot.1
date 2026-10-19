Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF487CCA46C
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 04:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EBB480BDF;
	Mon, 19 Oct 2026 04:54:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dosx48AnLEkH; Mon, 19 Oct 2026 04:54:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AC04080C47
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792385660;
	b=Nubz8JqmuZXrNLylDaiDnjW8uD65Oi2QULtQxOq+fkWgl1dLDdr//f8rTyTh63jfNGfv
	 U630Nu2Og1r3b+gCuu+FKQLZeV+G59YtkfNZw5OAJ+SalE1EhirUlWBikAh4Gx3ztpP6X
	 R+MJ1uLx3L+q9s7KOi8jI5GR8LR/VYDRHj9weXw4MeOUw876e5cXwuM8rnxx4JPmdngbR
	 MQPgykpv/9ElD8oxkd1nyNwJ7oIjDgNO225AhJ4220O+Tsrr9jqCwpEGujRhE9UZoYr27
	 iIPzPfuFkNW5Y3CUDzjy1NHJvqNXgO30+jO7qFFK0Ps7NmzJx0mGJv2X85LV5o49T9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792385660;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QA56MCD7Twf/aJFcYV7c+W+mbEm6+6MhsixyprmmeAo=;
	b=R8vPfXxg6qQKAZ6IiLStsEgAQqy/k7NxqOT7wOk2pksbnuThzoRPZ4VuY1fJX4kEfJDy
	 NgnKlD5ISlwSyRQj2bvisRD4kGx/WITqsdE20wZw2vlmZMQC9LHfmSTNviZBaiJF6cTV7
	 9pPc9PmUtzDdvaPFkCdu3fsvryioqYcnhgmLA2DAtGnRadVc0ODAR77u9vP2spkRr0TIk
	 ZI+muLHp1SVEXYpI1R4xGDnV739SdM+soSorpfxvb2mEWKoVAudkO6PTj6envhhRZDn94
	 ggKOPl0MNqdoS8WjdDc7W8xG1dX7fd1kLctDC9R7IUy8chYLzwI/Rjdo9TN1taftnCA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oj4aS1fs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792385660;
	bh=QA56MCD7Twf/aJFcYV7c+W+mbEm6+6MhsixyprmmeAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Otp6G6eKSDNaSNCM4ntbmtlmjuO6gCEQRJgTSI6vW4i4ui7uEsWP+oYwnPxNa18T6
	 gWXB18ldjlNor1AlPqrDVMS3S8ggGb9dmo6fi9T2FAXUqXTSIJhaZxshA9jiGY+WCd
	 YFmPsOgHGJzflQLTDlx7MD79yy3gIKUd1GNo4oCGOJ/exV5Y0yGGLRn3IRxkyqBMhz
	 vCKfPnlAaBAGt/n0DRbRGyIAwtgahFLRDzKfOXD8AUkYWocnjfB+zsaWqFCRYcgPbY
	 ZkIVliOD3Xmm+M9W2LBJtFdWq6Nb/8sDifemUzRO9+n6CtSGCGsaf6wDXIXrCwvjVc
	 bOc3ez3EiRL0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC04080C47;
	Mon, 19 Oct 2026 04:54:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 364DD1AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 04:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2779D80C47
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 04:54:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KtJB1t7ann60 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 04:54:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 16F8C80BDF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792385658;
 b=eU9QMGHLpjDc+l0nDeTtWhwNXZSN1dsr1U4yVLJSgpwr+aX0TgsWIhFnmQOzYWYUZoP7
 5tS8CPtj4TKNXqirCn13keboCuiTGnEbB8cL9hNkdc2zwgR0yHOoeR9VDTGHOzsSBG9PX
 VvF2HOwZI0fphTaVgtrqN9v9BcVrbKHzGF2B1L2HLfX6u8Y+Pe9ewYKfN9r8yHaA2mXYK
 2UdeQDAsHf47IkQQXWN1xXBmj6Blv7xQ8cA8VzqPvmDQTYOjU0Zmi6739IC9i6Boyt35b
 7Y53MKHj+tv5dN99a9w5UGMUtX0onnxpbtMHkSYkblRFFNnUJ/V3vJ+AgblaqNChOKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792385658;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=QA56MCD7Twf/aJFcYV7c+W+mbEm6+6MhsixyprmmeAo=;
 b=j5IF+p1YHdEeEz39ePr+JkBplfK08drzln05KKCDmVaP1ZB5x7EHb+upxz7bh4TvE3Qa
 DyzUienTBA0S+w9mpzzAmE+8yfvmj0cy+YOR30hE89l4xQ+BIa5CbIjK2l1sc8DVyJkkj
 Ia7XMz4MTPcIBXwEJZYe60+JsWgoZCXO03z5o/+XT9bWSlKHR2bpJ+UUMDIDnS80bIPd0
 GdB4ipYZZQyTlHJj7gVjekREC/xtT4AM6QJdnxKp37gc9UnIS+zakCh0c6rRYJ5txTXP+
 kStDZexIVNzy3Z+B1/lUVGqkkpd8rOMV9xH9hSLFP0b61wudYiv6szzPSdzTfxrxpfw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oj4aS1fs; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oj4aS1fs
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16F8C80BDF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 04:54:17 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48dc202a60eso218979f8f.3
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 21:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792385655; x=1792990455;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QA56MCD7Twf/aJFcYV7c+W+mbEm6+6MhsixyprmmeAo=;
 b=oj4aS1fs24GdUDcqB3jIPirhFtKdmx+iLVPY0kNgxEsaiCZ8sGAULW0egbSBKHyZuQ
 p4tQSZTRlg6Vs64eUTAG6t3tlelLHxT9qbCuigtP2F6U35jJJUIGV+tuasK43bzWLHHk
 ccJYbBWyrJZA6+Ny19zMHbYbpK+2J+j4qQef8el+6RtRSz/m97XqHHyb+IOeAGQhfjC3
 P1WQr45CfzBGhrwYBOZ84MQAv6beoKsJZVIi8aE7wrvGyGrlscy9oe/5oBGkgC0qY5kU
 iX9/Ufu7DmU+XIgefy3saDBFDYjlU3N/TaFzG0GEg841J5C2NVkOTlLAm5xsJEGXDxI7
 MMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792385655; x=1792990455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QA56MCD7Twf/aJFcYV7c+W+mbEm6+6MhsixyprmmeAo=;
 b=dY6VLHGiDGv/qqgAJDc50L6abYfhJQpAWFFQHoDwtcG7k/k1v+YarYMjR3IHt5jB/0
 PXJR3ajqCex9gLgZvVIxVQQkvELdxTW3AchCAEHaoKL2XgV6y2uXcUOibBHKyy5vFfb+
 9ETcxgBkBpMoDqPwKUpW0Ea/vELdnrFd5mBr9Ycu9dU2FzqpZ+BY/b71QYy4XrrCUil3
 A35EXEM05RGW/sjawB/iKatBw2rpa3IYV6e0/hTWQ/vWVYQnl0O0aNTrOoaS05Souxb6
 lN9EtWRHKcSEeIWNvZDbtefhF/UL+P5F978fGU3BhEgwnON9MmohPp3XOl4SCn7GVGC+
 yj6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCKes7PWeYe0/vXoSHT22gDodNR1L0Mz89lrGVkza+84/Qe5lbf7nEiJOZRE0XZ9XALpJXrtA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJSQFwfwL91k3HpRuR+uERz/K8sdjEtX2s1yMXN8lPX2Pe2WInv
 oYzaN3TJ+2q6RuH+R4sshwrr4OdrnkoSUI1gXVtdPc5EXjhw2LfGPv58
X-Gm-Gg: AYBFou05EkfPsgVxBrCOgEfNa8830SPtMmMbEJd6JdpyRsrB6XOsTvspOy+blLb7OuC
 GqVcj+yaOarsFD5KaH51qaxArF6mJqGhw1sJNJtkR2cQKfBFlKBoO3L32c3UFbOTSxEd0paHYsj
 M3nVm+Tkyj4ckuB2Sxuiu9GuODU2h5EDP5WaJYZ7JDUC5weZNxhdpWHKKjdhevD6JbY/9QCFU3n
 sa5B323zoi9HvRfdgWnQzOeha5nsU2WVsIEKa3iwBY7V3slworR2WkS94r3Tn/PUAl/Ev17ju0f
 DIibuzuNdGCcacPjHTEG4vx3UvO//q6WgzOeOlc0T5DhpbwBjfnt8UNnX0pI8KSGL5AeyThFJ1P
 VDok01cE4gtoxw3Pl+QfjdE4gMJTNMKtrpIPXO0q90ymn4CF7q5HmfBTFhYPLiyIwFwbxSX+PaT
 9g5aUoHNWvCA58Oww+XJI3216/naiJUthmWDZF2+4s21lcFQyRJh+4y17ONxy7qpWC+PtYYT/5l
 n25Kg==
X-Received: by 2002:a05:6000:41c5:b0:48d:f996:1814 with SMTP id
 ffacd0b85a97d-48e07faff88mr14138280f8f.57.1792385655187; 
 Sun, 18 Oct 2026 21:54:15 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd503d78sm20095320f8f.50.2026.10.18.21.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 21:54:14 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: Re: [PATCH v6 7/8] usb: ehci-vf: take the register bases from the
 device tree
Date: Mon, 19 Oct 2026 06:54:12 +0200
Message-ID: <20261019045412.3193516-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <8ab82798-f91d-4337-892f-3e54a8980010@mailbox.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Marek,

On 2026-10-18, Marek Vasut wrote:
> It seems portnr should be unsigned int in struct ehci_vf_priv_data {} ?

Yes, v7 keeps it a u32.

Thanks,
Mehmet
