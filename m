Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BDAC5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:28:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7C8C40C0B;
	Thu, 13 Aug 2026 17:28:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s7uXxj8CV0fZ; Thu, 13 Aug 2026 17:28:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E5645409D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786642128;
	bh=HPRRNU7nMhaRCtWZ+NnjOCQbJXEcxl0ooVRO9nZlI44=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tgsWA2fkJzkrsX0WAiikJtGOqWF4NtTrhTDAgeHWUTok6RcDobm08heDpz/fO/CBP
	 83ncbCvwn1USvR1rfFdra8IMlOewM3hKr8y6/Mudz1UZxeIlluiYO1M/XEoVUOn8Kg
	 ikSA+nxeCYfOeu/1JUa0Y04YFWaynQ+uINnuwzDGK+LAM8kQGylZyoFDK7wrw7SxQT
	 Pdm+G46PEn78YH03Hc4DQjfeMmzLYPtaaG2Yw5GkxAWvqpyUVb74NBm9avZxykFJF1
	 S6/W9h2JWwmi1B5O1su7JTapa/VN+pE7L5GE+jyEs2UX5LzGE1FaAygsi7hNMsPbad
	 GLkYEhCaKLwSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5645409D9;
	Thu, 13 Aug 2026 17:28:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 77B652DD
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69DC640808
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:28:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FnQ9bbrxk3ic for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 17:28:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 96B8D4080A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 96B8D4080A
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 96B8D4080A
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:28:43 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7f3b01b8996so9961a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 10:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786642122; x=1787246922;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HPRRNU7nMhaRCtWZ+NnjOCQbJXEcxl0ooVRO9nZlI44=;
 b=QI7NDlw3+LjPKFeh15AkRZpVrm/4v4E5JUrd5T+QnV8q3bNVit0DuD+u9/uNG935I2
 m8YkBVtVjoGV428kGDZZBtj2bsc+HbEBvnItdTnrSGLznttM/G1VFBozpVdnoeEhO+ac
 b20eMaYgE79b1zYF/9HHJuO2sl6hsuSGixOxooUovUrz+oqskjWAlVpjc/LLHQ23+l64
 9oz9pH/vr/h5TRKSoHpA+XWS0jdvPgLm3nJX7Klzk6Gc537dFlRY7UvbpWPO8UKG2sI1
 93TOavVmZ0Yrd1n73is0kZXLNZa3H7B86uF3AkKFdJcWdqXe1OJP8FW+IiCReWldJFfn
 j9ig==
X-Gm-Message-State: AOJu0YzWpHxTvenAzwge1OgOvfDn2V8t0GKjCtT4qszTo4ZlA7bsR2Uh
 qkmwElQEz7cuQuIij/1T7z8KsSlmSsTIGY4nGnunkucHCKxdwdKwsuX41ERjFl4dnj7W4qYzrY0
 4yPksP54=
X-Gm-Gg: AR+sD117An1//R613ckeH05GRVFAhjsA0LJvrAkZIsFOclYYEYlu8yvUfynofDdGcwb
 0+vEU3X0u4hluKkuGCCW5fSKi8mAkcavRMkw4a+6QAHa2BRN2ri7gYBjFEd2ug5ZKk1Q+RCd7ul
 PLT38TC3l4hfgOuD/3sDoL99sS74c8cMQQUJRnpJsPUQjw6mgiNEjsEPwkHVyF8eTqcFLCdz+cg
 6yMqc7/dTSftEmAzUNwtwQ3JOhGx+NeFLIF/+QHdtVIWXUnq0+7sXL+l7akl5sXsFCPtt7pnsuV
 V+0ywfR84osLHSNZSAhi61ktRcW+FJ4MAsfv4uBEoiv1XPQ3qCDPNMzuCXVn7PIt+3YscJgOwdR
 XyHKwtWkXzJgeQMGjkwNLy/Q/ZX1GpZ94VoEIt8CE6ctzKLJPcLOkl8mBjLE76RTMJkLfOuvLb2
 V2TuPMehzGzBBBlHeXsxt5el60UjDLpXC3r1xUchZxmfSlQqZNhZsmoM9EypRQmST00zZUxw0wg
 A7jFq2skfe+egfnKe8GWcH7IhKfw1qmP3FKPWuXzEAOgv7r+aY4AoT/dAVhOWpIXTZaqdyLKuMv
 rWhdL7ak
X-Received: by 2002:a05:6820:2916:b0:6aa:ed21:6c95 with SMTP id
 006d021491bc7-6b0d5da50d2mr218164eaf.0.1786642122420; 
 Thu, 13 Aug 2026 10:28:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0c42b7c97sm2962754eaf.5.2026.08.13.10.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:28:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260813141727.268273-1-u-boot@0leil.net>
References: <20260813141727.268273-1-u-boot@0leil.net>
Subject: Re: [GIT PULL] Please pull u-boot-rockchip-2026.10-20260813 into main
Message-Id: <178664212181.3617045.16374283039119423863.b4-ty@konsulko.com>
Date: Thu, 13 Aug 2026 11:28:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786642122; x=1787246922;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HPRRNU7nMhaRCtWZ+NnjOCQbJXEcxl0ooVRO9nZlI44=;
 b=Us0mms77/7su5ZXWapOOoC6X4JUijbnUK71/zS8DEE2675ziM54iIw+QD2Kv+IWKcx
 eEA4i4mvBK4+w7bETsT3rozoeR99enAss5b1DltXZqCXMMbva3BA9iW0IB4RxfAT/R2i
 0fmfhMbRc4LkS9y3J9ll2oB1SUdZhIzgn/580=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Us0mms77
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

On Thu, 13 Aug 2026 16:16:48 +0200, Quentin Schulz wrote:

> CI for this pull request is available here: https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/pipelines/972
> 
> The following changes since commit 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5:
> 
>   Prepare v2026.10-rc2 (2026-08-10 16:43:34 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


