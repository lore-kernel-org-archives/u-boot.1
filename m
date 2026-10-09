Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576A0CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2044781499;
	Fri,  9 Oct 2026 19:40:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2z0KYba_xnwA; Fri,  9 Oct 2026 19:40:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2E4118149C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791574819;
	b=GWSREyt+gcpm6KeO+Kiuhgv9NzrbHKxcBNnJEtGqSQLWf4JSJrtle3m6bkuSyTmEUxH+
	 NiMZo09yM/n1QDUq0NxDc4+kjouNp0q2bO1PjSeNToK7HCCp0Q8SYYr6QNWw478WaioHX
	 wY66/59h6dufuncDYMlD+fTDFCV7CatCgOZX2dWBNKMSWBe3O1Zuy7CKEvIVRYbmTbu8Z
	 J9JZFWB9KgLl0EBHyC5/Numw0aBQwPWkxzLbZX446/vkryL4K883zDytebHD7irfkRQro
	 MLdbXsm0RiSdJtRsd3+IM9PYdCfLxJC0O3nXHAJoBtiKyNO14F4wZNBcswlyL4zlusg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791574819;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gqnjEMXbUztlWIvjCBqXMTRt2SxS82xZWOPKYuzT8CU=;
	b=mcqUE9rlAYx40orPfNYBgdUN9OslcKSBQY2AoSwgLDyg+xH/1GmR2qBrV0KeWa7oWLtT
	 EqVtzKZk5oyHxQqYqBRJYt0zQx7/Xcy7csCQJvd0RtJCHYLxbzxWWO9SqPujJxuXGRCpx
	 zyGbi/rZQS4olY5vpJi2Up+iXRmkgaHn9vkUlUw4zEAlEaikP3GhFzqHgIJzo+yEXg2pj
	 aCzzAK7GLFBeCKyX+/jVcwgMv3xSA5O66WgXeDP55thrDWT8Pb2vpKdi76cH16MR4tKVs
	 e7Thcdaz6J6pT8nFhL6Kg5XAGAO0U9XbsFrA+ZOPsv9cz/hm5z8IH2LHoKPsNFiJFrw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791574819;
	bh=gqnjEMXbUztlWIvjCBqXMTRt2SxS82xZWOPKYuzT8CU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pf43ZRD/49NsOZqAGRt9ZNSPsqWRP3N4SuQchRko8YwkBcuwhPCb8cD4d9+lS0Pwh
	 yrSolLIx3Y+IX5FXqwS0CW9tK7kFg56Gp5316ymv/mzLvbwIHfu4arNjFyu1s+c/lE
	 HJKZRaWsHMhCeFnJB2JFPQC0EGANzsZsxUyvSu3yfQlRyVZAyfth+dVfeIOtxc+zfK
	 c9KDYmZzfoQ5T2npUyvWHKr8Nf2zc/zNyW4f9jXZG6qqGPAMMJK6vNkqS74l11tKYA
	 1o6dsLGRrruGlDhmbePTbK8paswInW6EZb4UWqrxXpDTxlegVnCYJ5DHFykLMffl5H
	 lPc1GrXK0VP/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E4118149C;
	Fri,  9 Oct 2026 19:40:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DD0D4356
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CEE3B40945
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j5wMbKGVou7b for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:40:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 05C8F408CB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791574814;
 b=GMKzZlSX89FyRpSq/Y5MYyEIIKWRbhsdcOipA21lm2zBRhjR527CeYbqGTn8jYrT4mUR
 cmFmBJ+NsJ62yYE84ueyZol3Yls+woxxMBurokyxRveMW32YLXef4LXOXw6ERswSxCIXw
 mChaCOGlHNcnXMDOqTa+pbQkEo7xb8NDacTAB/vPHKOyRRKt2ROAzW9rDqvn7my7mZYHg
 hPFzEn3AqOY1HfEyb3f03bKfWJBGlWle5p8LHkaGQFWAyvIeDWrdaqV7T/hY+9+g38WbL
 fDf4iXJdg2l1MAKMLMhxpQpKKHxRdHyeEfo9WtYKt+PLop+H89MN41EtkO9q3+aiv/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791574814;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=gqnjEMXbUztlWIvjCBqXMTRt2SxS82xZWOPKYuzT8CU=;
 b=qocVY985gBy9sfIvXwwbhp3ByyW+qKerUd9UI3X9prA+1L8PLqc2l7k64EdmOtL7C+1U
 8qwChkzpv90gyjyiQNiBgajmna+u0hAQqDWfP0oUakTJMv6yrW2qhwEX56ynvmHnSxtgk
 QzVxBkZgWrcxC92B2y74M9b18HzebgX2Nw8PqWB/NjaIbTG9cR60xm/XCQxvsHu1iJSKh
 cAL9HMBuh8e+onNJhaWrpJTPobvwpA8EwLvo64ie3ecijKaGO+iQNgTg7cRcqacLof8dg
 ZT0MJirU8VK5QaCJpaU5eWt2hXnW5zqTW1sgigdeG4rfohUyy1CetLWl0q881Wf6fxA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=br+BnFVr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=br+BnFVr
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 05C8F408CB
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:13 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-82395ae2ea8so128544a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791574812; x=1792179612;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gqnjEMXbUztlWIvjCBqXMTRt2SxS82xZWOPKYuzT8CU=;
 b=br+BnFVrxM5LvSNn8SGxn+c5Qz0OsJpnNZA2XtXb0TXg3v6uCobjbs0ecY1cTziy05
 Jzl53G/dp1+SL/3Ssw9gLE7ZzbQId3v9YjIgerl0TDgFITaBHHjysdVv4LrkDbnCpCI0
 2THa121hEAjOpYlKiHUnEmgBo572NS1rLmCqVilsHooshlMmoGfklHmAk4fR3yWOl8dN
 aux/FFpVALQarGQyY1duymOvFm37YsO+hogmILKBYXCutXH1LY/7//gbQpBzOfUwtagD
 /Xl+nHnf0TNFjgPEkBcPE0LoI4dRGHbm6ug9UyJgUDavr8yKMLhMpkcHbZoH8aYlXhCl
 OUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791574812; x=1792179612;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gqnjEMXbUztlWIvjCBqXMTRt2SxS82xZWOPKYuzT8CU=;
 b=mTk88uAcmV37E7BwphgnVZ6cD+ne/qAhWojaji5JfOsS8MZhAEd8RkBfIGCFv3u4Nk
 9AUsKAdpxUfAecTxMWKpTvdzYACzV2yOk1K33S0+j/eEpTQoG6WS8c2wYmjw9eY+jJq2
 O12uflXcF3E4Qe06PtacEB86mtKQPSURDCdbIX46bcdvKR8oIHqTZGx9kMOkf88sUIKU
 dH8ix05OEg7HuTQhNNWxiagA8yccIlnQsw+iAXp7SWaVaCBr3s/uRpaTzy2tcaWKgwiM
 PvkVzO4cj+JtueFhaZsjINBDChsyPVruFAKDwfY3TsQzu59TzRb5JY7O6CJw2rdKkPVH
 hRMg==
X-Forwarded-Encrypted: i=1;
 AKwUvByXvl05Y5wdfk/3692O2pmzBCvOeBiHMGjkaiuck5KByzd1reJ8nKRRfBX7c593B3wguBMpTkQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lKYw95jVvD4C835oAwTTSexcr/dufZ2e+DngjI3SytvsQ7OY7g
 SG7ydVguvT6tvfDEmzCJ95W9OdsIdiEC5TH9fXfjnjFsI145Qe732cClzK70yF/EjUnzNNe5ARQ
 Bsae5
X-Gm-Gg: AYBFou1zGJc6uLHm1BUDQP9IMVUvMziGSAFG7wPrPP4pbEHpBDC4OVDR/VxeS95Kz4+
 GNWNrRgwfVCwE6SX5uNLPV9fJiS6Et/ZYEjSfNFfIAmSzC6ezGkdHFDZeekyZw077bncIN/eisJ
 vByGLtDsF2H8gp5lNDsUpQhbbhjfUZ18k1TIxqde8bf2JAZLBDwYBmlWYyn55MwRComoaHGkj3y
 6qFI6cRfVGe/THpftsYf3ICIsqoeSsOx3xzl3goWFtw1DiHxKpVU6aTTXp+F2RhRwnhuD4rngxm
 v4K37QuupFVLab4OeDZ77xZbq+A07CSPCSsMWCrN0SjS8iawiv1QlR1xXFDBxOco8KDEdHP4yOV
 CIU+Rcuc0aT5eZAO6sj70wVL6NWGnZ2xhf7p1TQ2r5Iq6NqpQtGb6frImY6wIXPbId/kS0sA+3e
 laWAXFo/U8QE8YUqVsuz4/X/nRsYktgCIy4wET38pZd1WktLMhnK1feQfWvh9vPnwCRmMFLI+z/
 EEEyecoS1ybnw==
X-Received: by 2002:a05:6830:4ac1:b0:7df:5fc:3fd5 with SMTP id
 46e09a7af769-83090653c6bmr2715987a34.1.1791574812519; 
 Fri, 09 Oct 2026 12:40:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-83039a47048sm2665746a34.19.2026.10.09.12.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 12:40:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Deep Pani <deep.pani@mediatek.com>
In-Reply-To: <20260925-mt8196-pinctrl-v2-0-edf1aac8868f@collabora.com>
References: <20260925-mt8196-pinctrl-v2-0-edf1aac8868f@collabora.com>
Subject: Re: [PATCH v2 0/2] pinctrl: mediatek: add support for MT8196
Message-Id: <179157479867.1248553.15209353794007181370.b4-ty@b4>
Date: Fri, 09 Oct 2026 14:39:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=548; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=+DNXJqjQyhm0TI+kw0NcwjxUhpDd4d02xOq7CTf89Tc=; 
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGLJOOgsYBVy7qGO9u7Zlh/d3jtWzRK4YvclgadhVqFdqW
 l1x//TMTkYvFgZGLgYTMUWWNxI35yXxNV+bcyNjBswgViaQKWIyKTmpyRl5qUUOSYmVOZlJRal6
 yfm5DFycAjCFnars/3QFBVxVhBS01yqJeGYLdksIKngH5bZ5KjKUPXv+6p/JxQ8WxgrSE685x8y
 do8G5Nib3SaPcxpIDn1oPst6fdU/Vxcop3KeZO+Nu32TuwG7+SZccWKY8et/QMs/JeorBaSM+lb
 UfVje6fZZ8/tU8z8PrxhV+U5/6uu2GaoG3D8dzrdV/Usb1kadnnxLD5FgFxaT2uVK2DQcNlq06u
 edmmunTeJUqzyJmhYV5q5aclXnBpRemVfG3upx1kdmPurYop7Ltv7Ub+09P4pxz4qtXaFpCGlOb
 gc/1O+nibjMvR8lcqDlyknOv4+U5OxPOifzm9vn4kvn3nEC1S2XrhCbeS7h99uL8nogUkxQz9qc A
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Fri, 25 Sep 2026 18:05:51 +0200, Arnaud Ferraris wrote:
> pinctrl: mediatek: add support for MT8196
> 
> Add pinctrl driver for the MT8196 SoC, based on the corresponding
> kernel implementation.

Applied to mediatek-for-main, thanks!

[1/2] pinctrl: mediatek: further increase max number of base addresses
      commit: 41828337d592240ea52785f8f324d8e8c051f252
[2/2] pinctrl: mediatek: add pinctrl driver for MT8196
      commit: 35ad65d943257d2764b342033aec087961b27eaa

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

