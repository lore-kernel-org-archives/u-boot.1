Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EA4606A330
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bXK6bijU;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=OUHTgCmi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E60F81420;
	Thu, 19 Nov 2026 19:29:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RITkmQs4tVGZ; Thu, 19 Nov 2026 19:29:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A933881423
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795116592;
	b=aeQntQOXFhmv55e35GL0N1T+BGaAqIc91wqtaelJpTxt2Hk2yqzOLYqbA17MiCBzJk+1
	 QOdOl3Bm2YKqF16Hzzj/1Ah9XsFmvSyNStW0koMrH2GhW8pxwzDReIJSR3z3cqLQaRm5V
	 L/4Pqc4PWxWBcZiWuDVRUzz+R6avVyKQTIa5YzMny72dTzACu2JJPzd/7AbYXGVzJqTi6
	 gGYsMm6ItPYKrd4LPCVo9hrmuvfFlMyLjwIpNReKHbVR8yI3eJEolHOvvbu1cAYq9f3Iy
	 CnQr5p0oYtY6gWsppKnix/DhY4DZ4kzi1mPlSOHuCzNAiQ+vpls4wrsUROIWfPmaUsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795116592;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CmLOX4ikYRXQ1B54BLFu6Rcg3IWNegmU0joeD7WTpIA=;
	b=QZFQh8HG4arYLlPemdsV/nAk/JkEzFUhZIdvsVbbjroaz26NCXaXWCxQP6QY9xlgylvI
	 X4RjfXXWHZfDDoatrJoj1W0m/ksQH0cS9UmIHV2CYUhx7JZYgJLBF4rfXHzyZGHND3oEN
	 EZuO1FxBmJjy1TBcluV/8646/zbNXFsKYcPlPabMShmKSGUlMahAzwkKWsiseHyNdX9EW
	 L8P7SCXpQpmJRfzVLs45lHE/Cfavm/SqZtQSyuXyaitafyfWyX9HeroZzmnsyuY/gnzB0
	 WDiMiZmTsAPFrTKWVs/CPsTWsD0XQIPEeMTZVFlqi5sgL5BUk7QxNb5Byg6vyggOrGQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795116592;
	bh=CmLOX4ikYRXQ1B54BLFu6Rcg3IWNegmU0joeD7WTpIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bXK6bijUzJsaS43HL+wiFM6YTeAoaxFqhT9VV+n2D7wGH7n0bLtvJAr6ejcz7gRAV
	 pMRHSSK2xR6WilIYnOd07WBbcMVuH2EXhpMGOAUGW6+EKllahHZsgeHQB7NBlnUe3O
	 h15soZgq/F+M1Hk/o+IAS7ZZOPy570QiYuhdDTF9uPRojD9YrAZY3YZJ2/FP2XGaOi
	 v/kLhMIG2pyaTxs4cWVRMN2Mina+ma4z1Laigzm4TiIfOOIebg2JhatHNppNtK6buy
	 6J1G7T1N0CDB6JaM4tmunQsDqEtXA7RRgqTgOAicZNrcFXy1Hv2mBdGHJkAYVQNqkW
	 GXwVxEQsCDZyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A933881423;
	Thu, 19 Nov 2026 19:29:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 042A622B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 19:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE5F440D7F
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 19:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eRPDW_wK_mCV for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 19:29:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F108F40D1D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=OUHTgCmi
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F108F40D1D
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 19:29:48 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4a68190a2a7so52393f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 11:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795116586; x=1795721386;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CmLOX4ikYRXQ1B54BLFu6Rcg3IWNegmU0joeD7WTpIA=;
 b=OUHTgCmiOjk9JWWLpM12KBprXio/rdkkLJSEN0L3LLXjn9XLK2cZfPv7AXvg9dp3f/
 0eD/OapUcHu7wUW6JhMB7PrkKIIQxATx0oN63jLnViE8PX3PheYj0RDokl4+7i1lft89
 guKc0zJm6QOfO9MFjyEPF5XLVYyilOn6K+goA6cuPch+1VydZz3WlvfqEMcuPX3RsP+E
 W+JWhbeTcb0mgZCQ69WK01Mx9z+wlH6eqOvs1IRhbjQyH/UDl4E2gZ+VXkescFmNy0qG
 Pyc2EfRESvrjCOvYZ04e1ZpvzORY9dwcwNxJU7aNPVvClY7+uH7Qrow3dweNUFA5OSTI
 DGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795116586; x=1795721386;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CmLOX4ikYRXQ1B54BLFu6Rcg3IWNegmU0joeD7WTpIA=;
 b=CeUNLCyFkhPrlptlU9giRvGBF6qKEsJSpw0HcgN9H5kC8Aj5/ifdbQNa1iHeJ5318S
 BW3lKPijyYu8FE+V/fqGyqloCr7B1zKvbk2uWYcpJl7ig1b4KAXw50SF3+cRINQYaJOI
 d7kvyhcVsmdAuBqSwCV0VMnQCOA19gfSMK3YiOL9sSgNO8Iu20KqzHG5gUAuI8xSJ3ZT
 Yo7AFGlWyMTSeI614DxFiPx2TGzxZEJx7By18s9OKN7bISYS7wNRD5Mq1SQhjhT9LRPz
 QiLaAdO0F/ouAk+gwft1HNa+PQpp7Zu6BBmd0PzWLbcQjgPR9Ug+2kP1+t2tONScAjUx
 6Nyw==
X-Forwarded-Encrypted: i=1;
 AL+hErGYFTKBlFWvvIC+xs3Rph5p2t+9IHI4NGvb4F3k8XFCBcXVyfAG9kOt2f//LaI+z5c4D+Sl7QM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9TpkjI8I/O8G34e31gno33vXIpLg2SakRSYgy9q1xRgHT4NGvm
 /sWkqeGqI1z186xUjbzGqPpz3CjyPSqqre+Jkg3oXVNVVlKrCBYTw33FJtpZEdY4FGQ=
X-Gm-Gg: AYBFou1o8KuDtHZuTVkLddTgY63I4VSkmoRaRg4WNiVXQgOB88wYBphQpWMpNYEVWK0
 ok/Im9lk7C+UTkbxkTwnacfurnwxZRS5vl7bXxF9/RacHBH+ttTOzqcRdpxXgxuHQ+wFci2RS/0
 Kn7S8I8MazyT9eWmTR6LJ44qbzhDRXhLE84rjqnf74q8d/ra/ta4hewnduX6t0MmpUmxK9RyHM6
 E65cnnlOUOq+CCPVvd0mA3s3nCbESD0OULRanh2e2STwxZSzg7RJh9mM2ZYwdjCBv4TDUfyz4aY
 0zrNhWkG89ENQuXqrVT2aFH8TjvJUtjp1Y+Lm6kEX/P7YhcSlyWq20Zg4q7tFDSsNiUECmnlHC0
 HFdb9juAB5nP6OhVusy7HmUVHQeiYXR/5EWuG0YTsaeQZ4ggPWHYLj0TPmhqA+QiVQA8keU35FO
 /MBujbiys9v9wAD0d8uto+wNkwAqMQxacbCUwzgB2AEeispGk9LLkPCoveAOQXf6Qn+mgotsMTO
 4tygoVLOyJ1v0oeLBKyeSuISiKwxsyYtA2zV3gWOA19VLZO4A61OExYd1xHTroKwDj7y8oTfYKx
 P0QTjFTEaMvUDcuhBddR5icC6FgHRi6ZmqxhEGd2gsjlUWT074jZM6lbZmlcsuVNytRmCgb9lI2
 TwBYov1r4FfaxZb01maVMsuf2w1YC9pdqXn9cv6zqM9h/jQ==
X-Received: by 2002:a05:600c:5303:b0:4a2:1655:87db with SMTP id
 5b1f17b1804b1-4bb88785d2fmr14459685e9.0.1795116586376; 
 Thu, 19 Nov 2026 11:29:46 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf685asm1185028f8f.20.2026.11.19.11.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 11:29:45 -0800 (PST)
Date: Thu, 19 Nov 2026 20:29:44 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Steffen Dirkwinkel <lists@steffen.cc>
Cc: David Lechner <dlechner@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>
Subject: Re: [PATCH v2 1/2] arm: mediatek: enable the caches in SPL
Message-ID: <av9Nlu_vH69Ru7Qh@macbook.homenet.telecomitalia.it>
References: <20261109-std-upstream-mt8188-spl-caches-v2-0-78cfb3e90c55@beckhoff.com>
 <20261109-std-upstream-mt8188-spl-caches-v2-1-78cfb3e90c55@beckhoff.com>
 <26e0a77c-5188-47c1-a1e5-4caca8fd082d@baylibre.com>
 <a8d398c2-dc1e-470c-b194-b2fc606fd8dd@baylibre.com>
 <64e14026167e62b077a4999dd6283f96869f8a5a.camel@dirkwinkel.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64e14026167e62b077a4999dd6283f96869f8a5a.camel@dirkwinkel.cc>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 13:23:08 +0100, Steffen Dirkwinkel wrote:

> Yes, I also ran into it with the SPL of the U-Boot download agent and have
> explored some options last week, but didn't really get to a conclusion:
> 
> 1. A patch adding "CONFIG_SPL_MTK_EARLY_CACHES is not set" in mt8370-genio-da-
> uboot-fastboot.config. This works and only makes the fastboot usecase slightly
> slower

Ok, I finally took a closer look at this and I suggest to just implement
this for the DA-SPL case leaving out the DA-proper-U-Boot case. In
the proper U-Boot case caches are already enabled at the time we use
fastboot, so indeed we are only slowing down a bit at early init time,
no big deal IMO.

--
Carlo Caione
