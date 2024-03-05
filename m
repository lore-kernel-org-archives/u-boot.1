Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874D4C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 16:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34CC5880A2;
	Tue,  5 Mar 2024 17:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bRIs4Fwv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC6F8809A; Tue,  5 Mar 2024 17:03:12 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF83488094
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 17:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-68f51c5f9baso33425226d6.3
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 08:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709654582; x=1710259382; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5Xzbs1BE6MURxJZN9HsJRVOaV5S4Z+9b58vdTkatnQ=;
 b=bRIs4FwvwyzX0+m3I2gwGOPW4yAJSC6zuvvrG25wM2m5f+fgSlRrbU5JHuy0k34uud
 Iuy4QA0bovk+DWajlRpaH7G9zh63itZiXwyRq6WD4nQiV+y7QvrTBWPnf/XGpkHjdU65
 uYiP2lYvXzV0rc7fCjAOdp3t+T3VMPcdp8yAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709654582; x=1710259382;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t5Xzbs1BE6MURxJZN9HsJRVOaV5S4Z+9b58vdTkatnQ=;
 b=nCxASqFtyPR+8KajMtSda4tDRNgLqHxonf6JILdUlvKYg/KeFoDbph2YZRI593x/Kc
 8NCfTdQU2q3ZFXwb4eW2AihYjc35cZMJ+Zb6A7v+XEVfLedQiiFTHGG5W1x1SMQHE762
 FnxzJcNUiUuai+s0d64qrd7cTDzVHKYhTRbYwKb5QPCjBZ0lxarqf07aQD2BwjiG9O4r
 JoB6dRIWwSC9VGnbDN20spqg3zAMgjTLhKt0L80NBI9EbCFl72Ib2tE3YZ0w3T/1EVQV
 2ItKI5qpAgc0pQPCaOxvBHwHZ5155OhpZ3Pn9yTuPnXSJGV4KNxF8S1MV4pA5No6piOM
 LhrA==
X-Gm-Message-State: AOJu0YxVuqh+EUbWkI5KHJ0zAiqb9mfi65T1x64+P4qSbRB6kOblcWQw
 aFrrwai6DCcgjZFLTnr1UvQ/dmgN+QIG0mFrdbrEXhbAHjDIq/DAPxut6xPMeVk=
X-Google-Smtp-Source: AGHT+IEo4y2R5/MDH2dVrXo3FalevA76soICVhuLtHb/zqujxLdk9l6da96Bs9wIOS0GAAHtlE1/vA==
X-Received: by 2002:a0c:f0d3:0:b0:690:82b2:5fcf with SMTP id
 d19-20020a0cf0d3000000b0069082b25fcfmr2243741qvl.37.1709654582667; 
 Tue, 05 Mar 2024 08:03:02 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-007f-0000-0000-0000-1000.res6.spectrum.com.
 [2603:6081:7b00:7f::1000]) by smtp.gmail.com with ESMTPSA id
 jh19-20020a0562141fd300b0068fef023e6esm6382512qvb.88.2024.03.05.08.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 08:03:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-kumar1@ti.com, vaishnav.a@ti.com, 
 Jonathan Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240224002307.2284386-1-j-humphreys@ti.com>
References: <20240224002307.2284386-1-j-humphreys@ti.com>
Subject: Re: [PATCH v2 0/3] Enable OSPI on j721e
Message-Id: <170965458206.2808800.10198638459761855639.b4-ty@konsulko.com>
Date: Tue, 05 Mar 2024 11:03:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, 23 Feb 2024 18:23:04 -0600, Jonathan Humphreys wrote:

> This series enables OSPI storage and boot.
> 
> fixes: 58d61fb5a77e ("arm: dts: k3-j721e-sk: Add initial A72 specific dts support")
> 
> Changes from v1:
> - added patch to remove the OSPI phy pattern partition, as it wasn't used
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


