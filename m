Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86D5CA5FB3
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 22:45:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB89560839;
	Tue, 29 Sep 2026 22:45:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4AN7MoFEghEM; Tue, 29 Sep 2026 22:45:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 07D3360801
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790721949;
	b=Hy5sridZPoIYbAed1URytO+fGS1lNrzCR/MjBVlfoNb0fQxSBmTUkOyr1HvTmX4D8yXx
	 9p7S8yF1cyCnNok9GvTsYL7ZHVSwmPTt35Jyr4fc8t/39ZpVJ/FGuSAhzYNP/BoKkm/Nj
	 EQJ1rB9xKf2DskivVRB/0w9dYC7Y0Nx0MJ6hBdJohdcXAA7upUEN3vvhlwnMAO0ZJmGbC
	 52v9/LXir/2p3cRsMUd573pg+lTH0iDUvl0VgHvc1EuVf7YkcKWG7O4HuPJIKVDiJ0Dkx
	 y1Ir8I3c1AMpFZAw0D557R9qgBJ+W/CYvAePPlpE4ELec7/s5kX6O6j0CwTq50ybesg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790721949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=77eV9TYfSawcSWhCJ6woELQ04CJGHPx4+8BtswX9eCo=;
	b=ou/JZjL08UPCB2jKRCy3Zy4xL1PEh1ymTxtzw2YnC18ZByojpNOZf4u8vg07ziB86GeG
	 FufBercscK9IjiXpuCazL701lWScVpThyEbi1fdMezN+cL2hQ+8xIbeb1k4s8EliPeYVR
	 lfOgL1Oo0UuS3VjcTIM+BwrvHT794ESxfJYi1pgt+eA4czfpzZRGA7SwQYXjucenBVwxP
	 gHNTFoEEpKSk8s6ENWEiaqu2urN0Df/PXvCSGs0rFP89UdgePyP9bAIqKqk11IqwlD/Rc
	 1cX1MTl8mCRy9dtK21Fi7z4ES3GmX5XMKzOJlFU9cc21qyUFDGf2DrGrdouNxHma5WQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790721949;
	bh=77eV9TYfSawcSWhCJ6woELQ04CJGHPx4+8BtswX9eCo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NJfXtsk7K/R17MYyv8OdMGdbr6b6Io74np7GoQbj5GchKY6lUIAnAyJsGB1yjEM3L
	 XTfDa2zaEr5Z5wGzS7/7TfMrJQnbM33J47gbXMewt6KQhXD1pBtPnoIUclGJLDa2ow
	 8q2V2o4Ua8rI4oduy1uYdYEohMgGVDTV5NWmcUSGyZpfX43+oIWgCYpGWdod/n9BEJ
	 YtDgbx1dUmEfi3L0cRd9RfNpOFj+rglv8rqA7sIY4xtEsv+3PDITdXPjSfhj7OLnh4
	 QXF1S/ym+d1ETPLLcgSZPNXHGVIAyikT9wk8IW8sChm4HPsOokl5B+z7nd3xNfaN0L
	 zuliIGF3k3xow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07D3360801;
	Tue, 29 Sep 2026 22:45:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CEAF233B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:45:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4F7F4034A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:45:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEiwplSE4FMD for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 22:45:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 13AAD4034D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790721941;
 b=Yyq02JGBD9qUsmgHK2tQSde65VwoRkOKMMKff5YmFbL1+G+a4o4kR+TMC2FBg9GTAxM6
 u2wrDpZXkXYdzU3qxRwsemsRj/94SSZdTBnvXWiqTTMwufKvS3+yL6rt9myqyeOBen95s
 Y7WVng/es5EW+9Mx+70/vYYnmmlW2oHKJq6yY/RWa4ncF9U+yv0meLg1XwaTFq3z2qBlt
 pRiV6YcFJ0AxLAS5uHszAomyEI7TLzZjRM4lhznFWNQEFGbMYUFL3vKhZI49HCdcoG8qC
 N8kmztWw9OML/WjmyzlhvRE+bKxbm8KG5jjN93w6MJu2Si2iGaFP2UmxtJXNaz6zvYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790721941;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=77eV9TYfSawcSWhCJ6woELQ04CJGHPx4+8BtswX9eCo=;
 b=Wj1WAjUf35Cu90l9Wkw6VDqWdo4rhns4kZcM+ZTlhvx6j+8Nh5Oar7tsA7oiKS4CQMSw
 dyamerR8kmL+AmV4ri+Fm8bYDV35M+NjDDg/oGytDnd99xYX6/BUNykW74ZBXr6/lOrm9
 BM/sbawDgyN5MllL9SuMKDeUjo2lCbT1v1KZcewfk+iGe5/FlqI4Q24NA62MeWK2hRIJj
 uG3q6DOEpQe592ypdTonw3q1jzkYK4pyckwFqWNXLY5paDQgwbx1HXTWAj1q+hbUlsQFe
 SBi0qyxcqZVV2nyLqEkF9yeXilPGjHVPNDpFTP8YsZex6aGT8DDiG2MAP9sAkErCHZA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=DXa1fAn2; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=DXa1fAn2
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13AAD4034D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:45:40 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-81f707db14cso862393a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790721940; x=1791326740;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=77eV9TYfSawcSWhCJ6woELQ04CJGHPx4+8BtswX9eCo=;
 b=DXa1fAn2/KVhUJenmqZ5J1vqD9pJT8QBed8IMn5l5+eJpShPSRvLcv9RMIGGMS2hUV
 u9zpaKh4yJhCcPB7AUe4KoPY87tyaEK3B6Xuloo1NjeMq8jXY4kU04qrH2ObFoYVj59C
 l6CjUq152AidoQtjA+TLhfhZ51HpE5OwLD5u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790721940; x=1791326740;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=77eV9TYfSawcSWhCJ6woELQ04CJGHPx4+8BtswX9eCo=;
 b=bWpPMBHM/P7S6m9TI/hfVSqFR6TNbiRt91rWvm2l6qilDXtnhmfpJNx3+2hoLArcD+
 IbzCAyNNtIdVILVL/TZovHd3nREubzxn30wIldyz2gE8v592FG/hMYR1jCG1N/8Rrldl
 y/llrgzwkkMXkbJzzMcjxY93+scYT7xtl1Bp1l0ZzfawxQpk9CySwvx6PzuHyzYi8EgN
 uvqwoX6GVqeYdka6zqaeHkERLgwdnYUmFhSR9kdzZzud6cQ2RsaUChRrQ5ZbBy6Nopfy
 zrDVp4Ukmcx+93u2BjI85LPtdcaXBDltmoMGOdWP1jFcrKCYN/+T7l0pjI64W7FCE8FL
 QG9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBySCHldrnB1cVlOkx7kARIqGHuTZurKcJ+SzbMLyX6NBpSS2pnAF/bT4h6swKH+l2VKJU20H4k=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mlRKAI86Bw+7JYfF3zP+DyW4P2KYjWIUnyqOJS5UduqQo9t3OP
 7+PR+SfCYzw+pjrDG1vWP3RQSDrwLbe8FHKu3VNciSKAe+IXHJiASi2WKJklalDQhcY=
X-Gm-Gg: AYBFou1r2WbnG6BDBnzvj5TCcVweBk9F6JWP3+jcyFhyG1Ah2ub1QKqc1KSZeGSZlod
 R3kU4VedwaqT2ruF3LAUo1aBXg2LKJ2xXJ32z4rdhtQe8xlaVoeXWd0flIafpG9EHj7EJwhMVv8
 UzEpm7M2/0YTZu/XH4nLeJ3SlxI8oeEIvYoy+nx5hQ3FtqIfcMjzpXwVSANjENFj04egXYLIhV7
 b/w3e0/qGo7U5WcFmVE5GqsrfiuMcnZXMYyDQlHoJw4PoVLdKbGN8iE+7Jz4QflmznG+Ull/a4X
 Hq5URlTig12lYNOMBJMz66K5HeiZ0Hxt+fZYuXTYpNftpGwYfco99jSpO2z7x99/++Pm7w8s1Sj
 qxbdnkD4ZOzZpsu1Np33aIyhlD8+ofZyfrhUXbj2vqZy1VsSwW3yGWQ6fhF2kSn1HEiWfkCMYKi
 T34HE01+5OZ34ZnbYy4kk2BhXeG5IJ+aKJyVrbfW+W/NKanXT93sqNjLTlYOUL2j0+uSgrcYQtk
 lhuXCjEtJSPYp1P8F5RS8ERS7QvYMcb2+x1dl67jxPnAGpIxaeSkrAlI2LFB4dDq1W33DW7Bv8V
 T3uvFvKZiDEJGNr2IA==
X-Received: by 2002:a05:6830:43a6:b0:814:57a9:4243 with SMTP id
 46e09a7af769-81fd6616a26mr848981a34.17.1790721940000; 
 Tue, 29 Sep 2026 15:45:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81faf7eea80sm1159921a34.16.2026.09.29.15.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 15:45:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Mehmet Fide <mehmet.fide@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Ye Li <ye.li@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
In-Reply-To: <20260910220818.3093364-1-mehmet.fide@gmail.com>
References: <20260910220818.3093364-1-mehmet.fide@gmail.com>
Subject: Re: [PATCH v2 0/4] dm: gpio: read GPIOs in of_to_plat(), request
 them in probe()
Message-Id: <179072193843.236406.7642997259434316078.b4-ty@konsulko.com>
Date: Tue, 29 Sep 2026 16:45:38 -0600
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

On Fri, 11 Sep 2026 00:08:14 +0200, Mehmet Fide wrote:

> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> A driver's of_to_plat() method must only read the devicetree, but the
> only way to pick a GPIO out of it, gpio_request_by_name(), also probes
> the controller and claims the pin. Several drivers therefore claim
> GPIOs while their platform data is being read, before their own pinctrl
> state is applied. On SoCs where the direction lives in the pad register
> the pinctrl then undoes the direction the early claim set; on Vybrid
> this leaves a fixed regulator configured as always-on powering nothing,
> which is where this started (the ehci-vf VBUS supply).
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] gpio: add a way to parse a GPIO now and request it later
      commit: 4cf32565c3c44069e2015b309c02cd29bd590f7f
[2/4] regulator: claim the enable GPIO at probe time, not in of_to_plat()
      commit: 61665f113d3704311dd60aa76394a3abb44b66af
[3/4] doc: driver-model: state that of_to_plat() must not probe or claim
      commit: 6cca7e5498a7c5bc7b9d100a54b7778d3bc0c365
[4/4] test: dm: check the regulators claim their GPIOs at probe time
      commit: a338b718373be8df70a6ef8bbafecd4d1c6c4d31
-- 
Tom


