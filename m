Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3686CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 16:50:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCC6760AC6;
	Fri, 16 Oct 2026 16:50:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QXNF6mSPRxzg; Fri, 16 Oct 2026 16:50:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BF85560B62
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792169430;
	b=CtYuVbSLahhZYvw9N4gAkhSpe9OOI/JwU46kE3k+SBNNbsYNFwVd0mgVD92ESmSpfhpC
	 18ZjfiqvRjtYJRNV6cSmKkI9H8TT5+YVRilejLH7WjkzullcMa9bVCJfk31+GXohd8Tu9
	 pnpFqENHH7gSYsXf5oQDIgzAx+sKHxvAepPqtujQ9YQFiOxkzGXiIXJBLx6LT077xg37Y
	 RTDJ3P8vEiHYrp+20wAkhuB2qTuDlV5sj5YxHpJCwvtx1HWZYzTOO2Nx2UtDH5FUZe49G
	 e0qT4+NsDxM64q0KoY4hdewTB5ZOD8uSW0diQIPjZxxDD9Zyf8doZ/V6ZpsslRbzkXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792169430;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ksxZigutRSi1WxfhOWQYExI63mc0MltiUPK0UtSO/ic=;
	b=SVFFrH4IMvJH9JrgCsDRkje+9348Ud8OQXQgV8o+WExDWLCtWrYkBvoteQP3wgEPIppt
	 f6betxr39f9hBOOI46BQg6tL6rFjGNcnjgdXki15Vg4Lemj7gDyBe29UUs00QnKpjDRYq
	 3a8lti+A5DoOTqVyewLF1KOd/w4m6utG9glBEsrPONwNdnvhRmeVXW6idgjzF3olCcBQt
	 JvICUWvDk0C4tVkWO6f48Hgxh9eOtXQ75OV1OYEWeACB4JR5ufblbGn2pV873AI3JAo7O
	 F3u49qIi0q8lm7Grg+bfKkWF3NxFoObbdNuiNoubL+dARF2TG0ZahwiBmFnH+XDht6A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792169430;
	bh=ksxZigutRSi1WxfhOWQYExI63mc0MltiUPK0UtSO/ic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o01uKAA+dhPFQz6BmGeRHjNlL4fu1u0JNbtGvyH0CdNMdg6Nj59LrSCmHn6FPo1qo
	 +WSN7uNXVkGw2k1s9KM6HozjMPw4sEUeC11VD7kLoBCu9Vd/otkwgVtk/DWAR1qWGV
	 z16hG6XQWpkNDMR8iSvx0ySreP5MmJrY41ovoN844R8lkTOFUn4MQApUBYhI3RA5oT
	 DOSBvvn3uWT68dngKW9qu3GCcQNNueMexHttxCLgApdCpNz540XsIDRkN54sd/QWNe
	 p//VUB5b7/gO7pqWZ/3TqnzHyNaSHig3UPHgu0KwE5WgA/q429BoELuoI4Mq6l9MSt
	 YqXeNRvZHv7Tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF85560B62;
	Fri, 16 Oct 2026 16:50:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 04E2479D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 16:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DEC7440087
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 16:50:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9RlEyixXl2D2 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 16:50:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D99D740042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792169427;
 b=dFrbnY7COwJk88icsbsXdFgOe2jpd/Bk8HPrb7HkE0LEJUtxGN24U9Q0Nt63YmaoS61O
 PlKqalVcqV9JHxN75/ECaSvu/UizHTTlNPnuaeVBtXXeT2dEXIWIXGcmaHDsRjWO0ton0
 739RZYGjIq0BH+Y5m2zOmxjhSRdYvYF8VTaFx5P43b7BGDjy5dJRRh2pB527l8ztKWNqo
 yReuNs1z/z0YyBneUsxetnCqFZ4uYjGdJpFH7kPMzA08pEdRx+be7LvA/lKNinZTd0imB
 Q1KSkmtFHiA+YPyxjNLX8iOawIpB3RdgFfLe929nSm+fG1B2thSIKrUX9HaZ5EHBH5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792169427;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=ksxZigutRSi1WxfhOWQYExI63mc0MltiUPK0UtSO/ic=;
 b=sda+gWICWNfq3S8s4L9M/jpBpbEtXz2E/KgDFJvoaJ1OJH0RdntXKzebBnrS2OjYzJSe
 zL38+qi88Cw6thrDYEIKGhvOJHz1YNcXUAKFTJeSs68A1A5uWq3QnAKWuQmO59HJDjkeK
 RdW7CNxW0EHYm2jgFCqXQjhje7tmP2Q/mm95n/WWfiLiOZyEBULmh3muDJvzITx8f9h/Y
 P1fG4679DAfOv6KQYIeob3akGyRaXXjMMpQrOHJ/2qZFlELlmEwl1MDtzrnWk5kx9tSxy
 XVmrsqRzgsMHM2T6mESIRoUfLKA1/+LVtwreWfUEczlyyrCt6IlcW3s7IbJafC4aimA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=SvFpVk9j; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::9;
 helo=mail-oo2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=SvFpVk9j
Received: from mail-oo2-x09.google.com (mail-oo2-x09.google.com
 [IPv6:2607:f8b0:4864:31::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D99D740042
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 16:50:26 +0000 (UTC)
Received: by mail-oo2-x09.google.com with SMTP id
 46e09a7af769-821a4a69647so11520a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792169423; x=1792774223;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ksxZigutRSi1WxfhOWQYExI63mc0MltiUPK0UtSO/ic=;
 b=SvFpVk9jiyKrCc2mAdeQYfTZ0fs5tDCEjW1nMcKgAFmHyPp3hk5OtftflqfWWQlf3d
 Yf8IFhhMuZIneKKvFPwMOAmm9sqHxyqsoV7XxwIfmtzIAkb4RGvA/ppG7hJeDxKVH6O7
 3+UN0BnqxGEJHz9b3CAc8fxAwnOXNdtQOpx10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792169423; x=1792774223;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ksxZigutRSi1WxfhOWQYExI63mc0MltiUPK0UtSO/ic=;
 b=eZyRohPuOKHB+NDTxOy3WuuFpiJ02ezr6SFcGPMI9qv7K0cbCUE96mEGKfkcBbu9oj
 uLroDU+2o8VK64FCHrW7coOMiJ1XzJkq1YMJeh7ArU30MCr+f/4/Laoa9LRE1DkUJrwJ
 wYoppP70J/wVsaiND3ZJOt5+zbkU7nfkyKeUil7kXgLkqGPuDa1rHURI3fk+rV+0klQi
 m6ie2RhVrRB/xyACw1DZCmIg1e6d5GBClsN5MeZbZjhHZpbHkzqvXcPSp/nyKzJMLeFN
 b0sMl8v10csnyWyyqVVM6U5OY3FK4BN/mUX4TLhKqPkkjUfJqCTAFhPZwjL2mhesqXIw
 zLdg==
X-Gm-Message-State: AFq9FYL+RA68n3Bl1KMG3UMkCiA6frrRo/InzQjvHHVf0O2QWRhGEe66
 SIW0XoDcT18YAjJ8YwelfiwOPeZO7oz6o9RNy6nAen3z834l1qGaMH6FDSTvqHb2+rM=
X-Gm-Gg: AYBFou3ztJkBFpz7PN+wM4Gg53ZhYKS0wiCCFh7XGVry2nfkWZ/l6kYk71D8IWNK7mI
 cDQaqQYn07AxPMhWK0d1igoLRRiy+xPECenX4Bfotk4Wj2KbaiAvOUjyc+zoRkY4ulIUg0kJc8i
 n3hFwuw16Vr0Crif9b++YaZOcrIewwkUj9O/jpm8+dporEdVj6hTEratCjLbNyVKCrlZa6DTCYr
 VProVkZhXx/HpSpQCDmu6So3vzHI0jtdAzwh/ab2nI00OzONznet5jKVS1tGHoRN/QjcGJQCDUf
 wJG1VqLI4XnAa5jW0+msC/ORO7d/rE2VAwRP0dHtyYfMtoMIMWvxTjLEDTPlc0xqigasu9E1P0w
 FfBSqWz3SQp9kRrQOShA8o48XuJk1i0vq8Efo18j5kypsFXqkOEGau+UXas/KIAIfr12mbrIRHt
 bb7aiZ4k1AqAYZRklcl6ucWtc8YuZbMroZ6dTLbd8gXl/EJGvP4zP+9Ycw+2Zz8461/E7yjr0yK
 Ii+5EwwHKBuqpLHWa7NqKJT7sboFyNWyOnC7vBp/6CsvCyTycFhsxl3WlwJO7tfq7jkyKywovGB
 KlImBHpP22F1+EcpzIGBrGsl6Snb
X-Received: by 2002:a05:6830:2e05:b0:822:27d6:c2ae with SMTP id
 46e09a7af769-844f9a8b74bmr111483a34.3.1792169423484; 
 Fri, 16 Oct 2026 09:50:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-842a111dda4sm2236959a34.1.2026.10.16.09.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:50:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <bafae7bb-0ef9-491e-b284-81631b175783@foss.st.com>
References: <bafae7bb-0ef9-491e-b284-81631b175783@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot main / v2027.01 =
 u-boot-stm32-20261016
Message-Id: <179216942273.4016577.9533153352920791179.b4-ty@konsulko.com>
Date: Fri, 16 Oct 2026 10:50:22 -0600
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

On Fri, 16 Oct 2026 11:13:04 +0200, Patrice CHOTARD wrote:

> Please pull the STM32 related fixes for u-boot/main, v2027.01: u-boot-stm32_20261016
> 
> CI status: https://git.u-boot-project.org/u-boot/custodians/u-boot-stm/-/pipelines/1600
> 
> Thanks
> 
> The following changes since commit 65a7532545336e4b73e049a69436e255da7df961:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


