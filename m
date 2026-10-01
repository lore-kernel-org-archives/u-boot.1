Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DFACA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 17:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46FEA8098C;
	Thu,  1 Oct 2026 17:23:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SF6FlptwQj-H; Thu,  1 Oct 2026 17:23:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 88CE680E00
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790875437;
	b=QrBHrFbqSVBJxSsPwRDXfN+ZV0RJSUJFkPA7RtcBiArZW7SM0KtDFkkodvkNzwE4hO5o
	 HMEyNFtTFqNmMLMKz77U2hWpdMij0OUgCTWxTBFU5RmZa4y/SO6foOld+zg33JtHqeYcA
	 q8tP1NbLmU7RMuynRzi7xfntPfB41QR+HOdOIgVtFJ0zN/m64AziVPi0bg0UKVefp4HuH
	 Ic6f7a0x2Md8Pj4/k5jvQ0oTk9G/wTT2Dnn+bfMTf/zbDkLy+mwtXMzfXJGxTbZ3C2rQQ
	 4xLvWQWLFz6fViKBoxkSlMz1wC9vkWiupmkUEczNplxxtk6r4rQ+qKO0aNZGxOeK2OQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790875437;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2gFdSc8H07/SA0QD+vQSMicpv8Y72AZnsMwkUvtrxEc=;
	b=Fvc5qza9A4iiQe2Kc+XJ2Y28Nao9uih8ow1eWC/a9HoeVD+X3lvyhYmY0sxFo/5bzX+9
	 TK6X3peB4F+RWbxIf0lFcB3o1wphQv7LdAHhAU52/OR2PHVCdQzube+wQjPPiBKXUW/eJ
	 5Yhe/VdMRJGygTijUWJmTr4seT1LP2+fAlrtbQeZBGHuFAEyQVR6KbaWsizlAWmyzCVba
	 VqghdAbOPoDS6x761jeNr4U8a/8sHxxyDA4chGTx30CHIo5WyUquBQNZi5/545xwRlMqB
	 HmpNI8PD+PoJVS4owibjV6u6GDrSJ7bqcYtS2hBijkv+XA7ZgS7Ca7VBe7lps3SWryw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790875437;
	bh=2gFdSc8H07/SA0QD+vQSMicpv8Y72AZnsMwkUvtrxEc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yA1AwKZxPHvDApJRNge1+ewnvULiiWwBEQ5bo0ZfaqrzhQ4ZTwpaVmgTTQz3U4QOx
	 joSEQ4CJx8DstWZZ78Uu3UXefxZ1NmufovyGpRSwtsn0qjxdEVNGYgC7LdcVEhBcNj
	 jNw338RkJkynUXY8lRPhQwET/9dOBb5RTyHNnypXl7Avm2mLgDe/UYYYXVGEfpCg0T
	 oOyl+T0AmunXYT3n0eewtVIcHOtTskZtm33xzZXXfLdwQ6UBFDLABiliGGMo4xADNh
	 aatIFCBg+mtyRDmcOTaEhrS1tW6hhfRkvT4L6458hikREIp2p/sZh4/aoNRzM81trb
	 /66Yn7IgrX7pQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88CE680E00;
	Thu,  1 Oct 2026 17:23:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B8BD22B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:23:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1271B4052A
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:23:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e3llCfsvBaBF for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 17:23:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1C07640098
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::27"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790875435;
 b=FIbJeVPG6HJLa8MYX8bIx5xwILLa7zIbdLkyylbY+eDPoiC6ktmeiHhAF5Rdsq4q7AIZ
 PY76AFq/FGDLTvbGvn4u1sYl6/3agw9mIJbuB/DW6zY5EEJF1q0cGPoVajZKJ4wwcr8gI
 cMRmuCJfAT5tM6zdMtSK6ZD+CsAqnUfkxNW9tPctyJyVXew5nS/3X/EbKNr8hHq7PW0A9
 rrFYEvWvP6vlluKVyZRdqhuoP6g0Y6CdWupeeQ01cKjY7IYNcnzWgBqJPWPuxuUmNfJst
 rKxqTungces0B3BbOQEKbFjVwOrGp+zsNrZKTcmenXyZGvaQpEwG5ziiQa9LhC9L4oA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790875435;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=2gFdSc8H07/SA0QD+vQSMicpv8Y72AZnsMwkUvtrxEc=;
 b=LPFC9NQUBymJvXTq67wfZm0kqtT2aRRXkgYNr5/LL16Wp0q26G6Q8yrMgNKmJB3+dmyB
 haDxEI/gAPMy85lK0FL3Tfy0Mied3XeXMt0zv++m32NJqM0llkdiup59oIaM+IqViGXqM
 EsWnn5+IgOQyZpjGci7DYp/VBnTGR73zoFnFVzSp6vlw2qCrUS7Km5YJeDeSpaS4dLZAH
 rjiP7jq5WZiWCdEckb+HFCcxA8q4ffGv6qPXXMqWzUjn+DzeOVo/rHKT2gIMsJWE3/8HW
 1I5UooYijwEQM7IpZiwDItM1e5j5Ask//PcovEziSGGXz8T3kFEy9YTFElVOmGk3eNQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=eTYxw2n9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::27"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::27; helo=mail-ed2-x27.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=eTYxw2n9
Received: from mail-ed2-x27.google.com (mail-ed2-x27.google.com
 [IPv6:2a00:1450:4864:33::27])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C07640098
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:23:54 +0000 (UTC)
Received: by mail-ed2-x27.google.com with SMTP id
 4fb4d7f45d1cf-6aa135d6e97so10782361a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 10:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790875433; cv=none;
 d=google.com; s=arc-20260327;
 b=eL17E3iBLxza3b2fsTWrnHL/q6N8qet//AcZh+xql6F+V9zXZxeM6CoRYOEHIZ9ZHy
 MgR4EXA0n6/l7z0J3YhnbaHDKhJ1wpnYrp6I5Df6ShdK7e066m5EFFAYWQbeb4scPO02
 Kq8JAlCb5tkug9A0eXON3TXr5FuRBlkO4WqusAYx0fE25C0CCbYx+2ne2nzo85d8AiKL
 DRJIV9JqD5qn+Js/mL/JjPhsEnSK9bpzV7bDTuCW5ZiDSKDHx/WtCyDHY2DJ2zyMEawi
 dyKwkdt6SogqSgXeAF1X3FbMvs1eaXLnHTpLfADI/05iThj06ehqY5rQ+xVE7vUhb2R4
 LLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2gFdSc8H07/SA0QD+vQSMicpv8Y72AZnsMwkUvtrxEc=;
 fh=K2wRAaH9ucaJd2sS37Dqsxa4E2UPayxCqiQy+IpyGsI=;
 b=I9frS1G5zXJkva8v0tiowsmGLLIqw1MnkrX6pCx0qfoYoaHUEXnqpGXVLVee+46yJx
 ZU+s6U7sheJR8c7H3/PJip8AzRj5FDGUeqasJ1jixk+04DCxJdgfjoYq8kmQ+X+SzlAf
 9tf2BsWf807q+BhyHO4Dv1NHf+iqKszw/G0nmnf9PM21wqdYjnMSjKjtNdjzIooubanc
 eu8cgJlM03n6c1Bklzwmu/ZelSRjnaQ4r914pqwGU398z+rVJJeGPpD3q37s8lMbxKTI
 BWCXdF1jE3meZw6MbR3K/xLBpPRLgVXXU750cpWOcPpJxeZx7KBC9ByzbZ/blV9y4fh7
 Xjjg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790875433; x=1791480233;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2gFdSc8H07/SA0QD+vQSMicpv8Y72AZnsMwkUvtrxEc=;
 b=eTYxw2n9fZwxI8sNXxIJqUNkyeN9jjLetZfz8Da4gziY/oMYqw5rXX/aMZ1hFYedNM
 G47g8+/PKtLe+kteSVPx3RW2S8tLYnou5G17KQrDAUCEFsQv7uRO9GzCoA4/xTxi3aQM
 9rG3+kiQ2roX1puMDaDUfehRZzWfdrMz9MX7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790875433; x=1791480233;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2gFdSc8H07/SA0QD+vQSMicpv8Y72AZnsMwkUvtrxEc=;
 b=Bvn5P51l+wzivjK/Y2TbcRYjITKrw8MmsvDhgtzWu9NNGwcLV4nQCQgQdR+tOFUNTi
 Ffqrtg2uMV5SQZ1aFbLLcrIcL2adumAcprR4aAJLhajC5mV+z6yfJs08Qt1eFj7/TjyS
 tF260AAwaohG2chhVCh8uOYf/1EoodG/n4JwRAakuZ2OoqVcW7lR3oLBpUVlwCYUgT77
 XslG/8DdZdhqqF1wHZfLbEfrWvUBRSMEsk1N6Yfzu0jTC7PCEHzfXrhSwlNgnpwcWli8
 qL2ZequrDHHR5Z9zUYHmknnEHxgWLHwbyzhBocPdRD8BPL/CpTLMbq738D0QJwZFu09o
 lFHA==
X-Gm-Message-State: AFq9FYJgQWmKIp4Jw2n1JiOG95Xhj6J5dKo5ycraLaDKlj4UoV80q+4K
 yMs1X4pBg99oEDuI1exGfdMAShfpj8X1O2L+v5jHvjuHZBIjn/EvN6o7bCy6sPYNKV7c6bOMhnu
 Rb2ki7xPVkqKu3dy3Liw1f1rDW0tf80H2Pl2vcxrbuRFX5XIVr59AoA==
X-Gm-Gg: AYBFou0WhPksXkaBjTb+QETO7o6jZuVs0c2QNy/Hf+MZP5Br95UpOmmXdutvnBSNpNJ
 w28uqeQ2HqRTko8f0CmZe8f+gx0lEHRdV/LxrzSxZOPIo1dBRuePaGE/lVx1YwAyk61w7xuaJ/+
 o3ncg+qg/m7MVfKCmD9dCVkm7pRYPmo2jPQW1VfdVqXX1wZoo7kL492bWqBce7zB/JC+mYoxDHC
 OrGOEC6rlAJCpM4Igaw1JX3rFQY9HDT0RJ4E8v/nvmDRoq53QOPDzysLQ5UUsiIFy8PV9OR3mEZ
 JdDOyOA25DyvsR9PUyqbf7KHGIIhkihju6NQmvad7yNDA3xzdQHrTzWC
X-Received: by 2002:a05:6402:439a:b0:6ad:186a:fda9 with SMTP id
 4fb4d7f45d1cf-6ae1985cb2bmr3461055a12.2.1790875432791; Thu, 01 Oct 2026
 10:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787272661.git.daniel@makrotopia.org>
 <CAFLszTixHT2ZLo92bURLbzbCjyTO1B1SsRkBXhN6FMcBxWhTWg@mail.gmail.com>
 <arsHHMG3icqe1WdB@makrotopia.org>
In-Reply-To: <arsHHMG3icqe1WdB@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 18:23:39 +0100
X-Gm-Features: AclHuK8ZDEcYNqyFQRCnazqbNc35v0U6QKZRgfqYKj4TuTdkLJF4fZ3m4zzPOB4
Message-ID: <CAFLszTi4rPXGNPi3qhqJwuFbBu=jWVFwtdp9V=rXEZd5YCdTOw@mail.gmail.com>
Subject: Re: [0/9] boot: add imagemap on-demand image loading from storage
To: Daniel Golle <daniel@makrotopia.org>
Cc: u-boot@lists.u-boot-project.org
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

Hi Daniel,

On Tue, 29 Sept 2026 at 01:32, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Hi Simon,
>
> thank you for the extensive review of the series. Meanwhile v2 had
> already been sent and Tom has already picked it into 'next'.
> Apart from one issue (see below) I've addressed all correctness issues
> you have pointed out in a follow up series which I have sent now.

Great!

>
> On Mon, Sep 28, 2026 at 09:13:53AM -0600, Simon Glass wrote:
> > Hi Daniel,
> >
> > On 2026-08-23T19:12:43, Daniel Golle <daniel@makrotopia.org> wrote:
> >
> > > The first in-tree consumer, a bootmeth for OpenWrt-style FIT firmware, will
> > > follow as a separate series.
> >
> > When that comes, will you be able to add a test for the bootmeth?
>
> Yes. I've got that planned but it's not done yet. Compared to imagemap
> and the dm-verity integration (which are both covered by unit tests)
> the bootmeth by itself also isn't that spectacular ;)
>
> > > boot: fit: support on-demand loading in fit_image_load()
> >
> > Related: patch 6 adds a struct udevice *imagemap field to both struct
> > bootm_info and struct bootm_headers, but nothing in this series sets
> > either outside the tests. The FIT hook is dead code in the built tree.
>
> You are right, that is the gap the bootmeth series is going to close,
> and until it lands the integration is carried on the strength of
> out-of-tree testing, which is not a good place for it to sit.
> I would rather fix that by getting the consumer in than by adding a
> synthetic caller.

Sounds good.

Regards,
Simon
