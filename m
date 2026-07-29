Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39646C54F52
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 13:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D358811A9;
	Wed, 29 Jul 2026 13:44:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QYQW9JpWn39T; Wed, 29 Jul 2026 13:44:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FA928119A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785332665;
	bh=OHuP51FcmKmcsPvZed23ZjFXE3vG+XFs3WDz5wBxHzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GFgYKau9RqLRRuxCefIS92EoED8pHAZFgP/mNHU8E8CuBP2D+UV8QJlwULB5pBBeo
	 QGncpPYtmSQRb0Xi06kD3s7tzpO7YpO/GAwZY2coR8l+UwtcD2dDR4/FiaNpXTGtix
	 MP0OpfAbvRKjcIlSmxS4boM3HIiMQARCMk2RY/HvZmFpRKVp3nQh8lUuTe3YygUExY
	 NRQK6Wa4h2h8E2cDfHc+WictAXgY1VfX5KCTt6WxcfPjmlOB9qcAq2+apLZdIjJC0S
	 y6e7lE2OaIWiAP8W0yjvj6YSeJp8Ma3jKxbsr/vmeFkQr1N+xuIQ91zi6ohjHhmln6
	 hYmnJBqOsjiog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FA928119A;
	Wed, 29 Jul 2026 13:44:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 876682E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6DCB44025D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:44:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yf-6T45ogHlT for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 13:44:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5210E40074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5210E40074
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5210E40074
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:44:23 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba320so1794613a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785332661; cv=none;
 d=google.com; s=arc-20260327;
 b=EGvpF5FQsNsg3niyXrwX3VSig7JzCXrvAoVzrn1GwfpvAW6CwlPGJKOeYgIxyDNCkZ
 usxcwILPEaG0uoesqo/HXHa1Xif8JBcyIeiT8DJONifBwXUpgZJMZ+5UJP8XjhNYQLrZ
 RU1uZe2wVnOKtnnanIU58aGnUvT/05HpZvq545Uu3hnxlowtkqIZcrjiAaOLODhH8NQE
 5xN6+D70+ahvExIHNHRhIZileBfG0KYXi0xxY3N2iwqmonInOkt/wYYrtP0lTXAGDaH4
 swbLTIxS7rHrONR0g0DdkeSUSkaP2i3yEdeWh6eV8nnYh3/cjum+3EWONndnWKvv1jlw
 VyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OHuP51FcmKmcsPvZed23ZjFXE3vG+XFs3WDz5wBxHzQ=;
 fh=pp6SCPpzdfYunHWIc4KRQVfsdK3fKuwvi2d7u2+nKis=;
 b=Azg2/Enph5PSYvnLTEiHu433i/b78D5IlZR+dYBTkR0DYXts6JRH5Tu1AVWjDV71BA
 B6N980SXKdFiQOYVjIiCSLn+b1XsihN41LrAwVMZqJlPofItcPjXBmoZPAUusOBMO9vu
 hjzoX0yUtY+a4OItGfR39MVHL9zoP0vMFlVvOygeHiphrngiHYYfN+uK/tX54MTkgVJO
 m9NeDYCjh5bHoa4f+B/k/LCePww7b6jHv53B+xQzSuEzNJEsKV/lY8EgTeIAVPkOeY2b
 f065b1FmjRMdtzAVvMosGa04WG/dclqM7CL8unBgDSmaAD7pvAuVc8oPRS+Yfr+sM8Jm
 5lsg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785332661; x=1785937461;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OHuP51FcmKmcsPvZed23ZjFXE3vG+XFs3WDz5wBxHzQ=;
 b=aOmnlcuisklHb89juQyuXuF8cWt/waHAaSumb6dzt14IxUdJPi/tzS8NUDXckzNQ9w
 qBmh2uacMdivtpwH3u9fBrvvS3gtMiJz/YBPMvjFPVGERTVN4JGDgr60dIxR+0Hn0U+M
 tAs7CjLRBxllTR5kbCejB/R5SsuECdbPznI48WBiRUfxCOlhPMvNNdc5ueMjKUz0IMkB
 Xc+pfzXWuSbIIk6WVbiPPqPT8v3VI7naWqLLhc6qJhjqvuhoLH1C3k4B288CvJoWR94z
 1Gg9SMjJNCxkBMvyRc4jCxtqahmvjyCcSF0kIqVyIPmFsQZ7TXdNKY5S31hmTd4/+wE6
 fRgg==
X-Gm-Message-State: AOJu0YwzEGAASShDUU7zRl/5eJJXndx+zJ7/6SpJebmaUCLGirtPvGrE
 XIcE8vHt+Fr6WrUL3OfSMJxV+aVNPZ2TU3zaJWTquTkmkhEJ1FsD3NhZWKLzNfQMx9Wiz7B411C
 GTaNliDDEzS7kuLnLY0kGbQfPG7luSHiT4aozp0XDal/RnJ2UrCA=
X-Gm-Gg: AR+sD13J0Mx9hI08OKLxZrL0DRm8QHXTdk2zYW4QLcBdfxy/r7orfu/DSfBt4Z7Okd6
 jDvHUAAWZS4LK11MhuEMN3McqODB552oucIEEjDQZlMWVloi85D6B/9pLSTAc8SwJtwIxpccs+M
 FpdXekCtMA0GB4vzVyXInjlpEGcGzC3p2/YaBp1Hf2Y1fKTM/PKc9P6uewCQfoZrB0fawinjn7e
 lpvbEUSt+hchAV10pf+zE/KRHREsFEzwbsHsZS3fHqaHPW+C1gqlXFpr3zn7IwOz70CUY57ZTkk
 2o8KX77oaFrqzhgqyQeRah/HvhTn4WTXwdWIJIUkqeY=
X-Received: by 2002:a05:6402:94f:b0:69f:eced:9307 with SMTP id
 4fb4d7f45d1cf-6a053004446mr1037576a12.17.1785332661481; Wed, 29 Jul 2026
 06:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
In-Reply-To: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Jul 2026 07:44:09 -0600
X-Gm-Features: AUfX_mwqdhLwMSw_-H7vO417QSUWrPYUrjV0W9tO7PR2A-mPY1iD6R7GIjSa0ZE
Message-ID: <CAFLszTgiNeufL2Cr57tx0wPkzwyBtjtAF6mDE=eLB5MCMpgeMA@mail.gmail.com>
Subject: Re: [v2,00/11] doc: clean up README.rockchip
To: jbx6244@gmail.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785332661; x=1785937461;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OHuP51FcmKmcsPvZed23ZjFXE3vG+XFs3WDz5wBxHzQ=;
 b=OoiJEyJ24rsIZXIJtvcAez9WLVHrGbFGVClB8WYF03tB8XQyCke7wHEmnO10TH0a/g
 CxHy6TOdmCxOVJB48iohU3yiL5WNtLFmYX5MMeRF/p3EQCUul/1o9GGTCsE06ds4tKFP
 xUMivq4WpVpdPUX1yNHKINbqUZnjKcBD4VNfU=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=OoiJEyJ2
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 2026-07-28T06:51:38, Johan Jonker <jbx6244@gmail.com> wrote:

Thanks for doing this!

Regards,
Simon
