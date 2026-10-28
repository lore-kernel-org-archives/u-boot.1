Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AEC606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=olQoCDfB;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dr6J8D4M
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F145E605CE;
	Wed, 28 Oct 2026 13:55:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZX_BQXs0ND7D; Wed, 28 Oct 2026 13:55:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2F4FD605F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793195757;
	b=n8Yepxiv/m5tOjlYsybQpTW2814E1rG37k2ail5bzteA6/G8XJRSzwEr3bKSp+ZrnS1S
	 EXRYgsEAnH4LX3WB3dwHt+5WieHaFBUtLIq1n0BlLNcOtLocxdk61qmrNAC594zxfXXoR
	 aKi4ScICq50AH8zFm8vI1fgHXHMdYOlhQUt4aHzqm/66ChnNpw0iajHAFsGdDyvwY+kd6
	 BPA+IIZq/SqDf8IipxREV7yDYNePkXiSbjtaH190pKUMKuZejBFqjrM/y3BKZgf5FC+p5
	 6s8V7l9Z0fnXdC2RSjHyhN50jY1zXfH7+w8Zw6KTro19sPW7G0ALrQIDA1IXW35upIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793195757;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Gcrvu2Blr9mEA82R1G+X/lMo2Wn8hreygX5lXiFS1pY=;
	b=ObS+++61jouZLHTIeR2KbToPMcLwys3wzonJBt20dIX3CgUb5eVhMSP+QNWKCD8ObIHh
	 oXzZyBhKec3nivaUbv7IyTW2G02aQwFQXjSq+k4LYV/MkdBw2G+HyAg+04ofNeq1t5AHg
	 jvxu0tNCRZ/vcGBd6m1VoIDyxJ4/1T0H0Uy+14/5KP4F8kaWRyM94mTVRZ+qq3FyB99bt
	 4hBx1kMRJZ9pboO4XPSSuDbq8uTIiqTo6cIukzs2KUiv3+fcVzg+9ceZvP5azpZusLDCm
	 UtvUY3BQiXDPagvIoi2YSKKKY5GSCgpz6X0ZtgRXz9l+uqc++6BH7puum+xVs04djPw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793195757;
	bh=Gcrvu2Blr9mEA82R1G+X/lMo2Wn8hreygX5lXiFS1pY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=olQoCDfBWvXhko7tvU8+5Y2eYvElchbBdhs1SpwiTAB8vZ5EsE2NehdrMSdEun3O2
	 3pyF09LisD92OMAvedtY6yNgMWTRlQnMDgGJDxfklF9UnhuabL9OE+w6fqkMG05EHY
	 gtFNYUIx1A4CkRuvjzQ67ZV8DZclvyAZxK2MzuWwDjBS5UIjuHZ+HPRxHqfPbMw4yH
	 DpcEUr/CvrhfCiWpdyZiQTecQFpGWE9CiiLzRZgxDlkUQyTWMolGidumdQ7Du3maRz
	 EnyYoMOqKPLCkijwoCHhJCniy/2XppSbPVsMmc6b9ay1YnG642TXy+t0z8e1hkDMZv
	 TRxAG7B5lo9TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F4FD605F1;
	Wed, 28 Oct 2026 13:55:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 27CE94D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 18F5780DCB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:55:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HsSbhOsHGpQb for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 13:55:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D92AC80DB1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793195753;
 b=ScA/D3bbkCRZe/lq/YBKrWV7/yAibFN3m2q8LJfxXyZOmduyT3Te3LeeiNkxtbH3lci3
 u6LofmOTBeCpwjUU8RYuIyaUnP/z/DDqpfZ0rraxk+ygh/KRaL1jgq5tVzjnyomx9kMsB
 dLavV8B9cHx7ODUj6mL39KRYCFyLV1OAHbXVYQ9jEvbG8T9yKpKXXnBEXJfQUK+B1DKVa
 cNSfnhdAm0W345o+i/b3njyAdXY7rtQjCmhjsqlFedlmmEarA8rJtL9Bb/mQWwvlU7XHf
 SgwVnXKsEMmci5Fo0FNgRjpMecDeUMzFeRmzK3CiF0MyIAJOpe9ZGkDIhzSfI8nyNTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793195753;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=Gcrvu2Blr9mEA82R1G+X/lMo2Wn8hreygX5lXiFS1pY=;
 b=pc4PrfHqXNyOYJe0fzJbDklKNNmcbXVh3fW/gIjW3JDeH8mozgtWoI+btZRJRu+aQTDh
 g8h6WEd7GWTgC1BHTIMMaBaNbyOItMBKnwI33DXpAfki69Pe7JFvbprX3dwKJPxIDNOws
 8GTnuC2qTrtf3hQC/IV+2t77g3CZ0H+dsUd+R+jRHLifuhyCO1POvd55OMRCzXnFqPPsq
 YzPKEvG+3W4Dfcceq41IAK5c1iX1/MEl0TWCE7dZ20HVKJmHTF+u33lAS4/kNeE8PL+3g
 imazufZXEFwahOP2GF2FQygdBJc5xML7gX+KFVoU2fjrA4N68wlPHVBmkORReECJgJg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dr6J8D4M; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dr6J8D4M
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D92AC80DB1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:55:52 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso6897775e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793195750; x=1793800550;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gcrvu2Blr9mEA82R1G+X/lMo2Wn8hreygX5lXiFS1pY=;
 b=dr6J8D4Mok6RXIff3e+Zyo9muk2DvjtRWI1X/5PkMYY0mpwEk2YPjS8/mO4HB9Atts
 LfOO6rvayQS0W7F7t7Sj49649Kg2XkD8Pc+4YzGudPjub81jlUfL6U4UxsJssLYbYxDc
 28awSIYk7szY1ED8Y40UjpM+mUV4WMvC4L1PCYsL5PLdQNwIigjuRcjnTsFRFWD3sG+S
 HCa6slg0H63POjtG0nrOXImMHPniiU3rUa/134LfutLigD1/MJu9p/WBiqAExFP4Uy25
 NmKqreMtn5hip378H71CJJL7qV2yWysfD22vt/MGXQo3LDCNv0Has2+pMCGv23jt0riC
 Se1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793195750; x=1793800550;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gcrvu2Blr9mEA82R1G+X/lMo2Wn8hreygX5lXiFS1pY=;
 b=O7qS55+WnQFooBdcJu4oQ/R8ICp1tLI3NVPfPatzx/p+/uSf2zFcYrVKmQIaV8w46h
 PpHa4i8edvblItxZ6MAcAULPTOuHSwyPfVw/TTsuliBbIrahSin3SnVxguAf6YrAbjna
 77F6WkVZwa0ndm6J5EKVm1KnOqWGnAiEV8eXfK7gg0zmei3rQPSa2LK2NDkyuxbLGTQ1
 aIuiY8bZ5I5Yoqa943SaQob9AKDHwb5Bam1XonW5j68NhWfQucElpxTU7YH96dx30oEC
 gLApnzKcXucWAxE4aMFpyyho2wKTKcEpEJhLkccDlWkXXTY61w4h2HzzGAUcd0pJT4ak
 JfNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7lEwSJOLIfNZ2ZwNcuEDKksTB6Z80s469aKr6xzLQqYFjMQlpaCP6wN7FxBWAC7xcarks1Yg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLHgs7YMvT03N+Cch0/7VuLeudWJTlSHAulPpP5Vr0czCKkkphH
 G7HLT0GMkcEixhWj1sKivY88DXVamqnaAMj0BJkaYP663UQiYC0fqGEBwZ4TjUrlOZaoXd9lM0H
 vQMHMWFQ=
X-Gm-Gg: AYBFou1Y69/1OhHFhWUwFNzSWWX3U15i7MBgZFCZgxeovS6WAQZJr5YwoCRtBc4eimP
 S7ag+hbDdfD0XTzSkiLtm1bD19HzTWZpWd73Q/0497ocrqV97zcu8TaIwcuQksgui6TUCBrPurg
 ggQvUnN5upefFh5oL31tvo66D28DxFmPASJI32BTrXDtMsmpSlljdf8BBWGAubDcp+TFuX4hLac
 BUWC/lFAWZAWSIdcXlP3461bsEhTbJMPDmxiRyY9gTfWVKjB76JvKfImue4aEiM0yKERuf/C4Xv
 y7rOG9KpryjKzck5rO8OiYn9mG8V8R8xdgIotT345SoH8hrXen87UXLI2D0smhqPzKa+m64b6h9
 oQeAMrm3tbxnLM0A65zfvLWgFZvUg9WVP22gkOXuwCg/P+jI8CfzNrvkfJvVlW5qheRjJq7n329
 QIhVdfewByyE4sOAYcMLCyVftN/wAyEXI0+EpriuU9bdzcsrQ+NT1JJgMHGe57UuPaJMUTAU6dg
 2x8+CmQxoI7ji4SXpn8dNuZUOKWlkZfb/Ee43mCLnyUq0khgpGxHDGC2JZAEMsPP9N+ybMxMVkP
 1GAczYUa7Gd+SrSPhdUPDxAM+A5OtARWVs9oeEd3QFzYdSnae3wQxHQ+2jrQJDoDta+l4g+bdO3
 mKDyyD2tYL8PPeNwB
X-Received: by 2002:a05:600c:3115:b0:4a2:84c:52f3 with SMTP id
 5b1f17b1804b1-4a96639b03bmr50638335e9.6.1793195750491; 
 Wed, 28 Oct 2026 06:55:50 -0700 (PDT)
Received: from lion.localdomain (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd35c2sm28111848f8f.39.2026.10.28.06.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:55:49 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
In-Reply-To: <6wv2gjh4bkxttxxriqx25k43qkeg2sraknwaffxahcyqxedfm5@uuxaorwsolbm>
References: <6wv2gjh4bkxttxxriqx25k43qkeg2sraknwaffxahcyqxedfm5@uuxaorwsolbm>
Subject: Re: [PATCH] serial: msm_geni: fix clock rate return type
 truncation
Message-Id: <179319574924.1318768.16958623727156592805.b4-ty@b4>
Date: Wed, 28 Oct 2026 14:55:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sun, 07 Jun 2026 21:11:37 +0530, Naveen Kumar Chaudhary wrote:
> get_clk_cfg() and get_clk_div_rate() return 'int' but operate on
> 'unsigned long' clock frequencies. If a supported frequency exceeds
> INT_MAX, the return value gets silently truncated or sign-extended,
> causing the caller to misinterpret valid clock rates.
> 
> Change both functions to return 'unsigned long' to match the data type
> they actually operate on. This matches the callers accepted data types
> as well.
> 
> [...]

Applied, thanks!

[1/1] serial: msm_geni: fix clock rate return type truncation
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/6add0b071e18

Best regards,
-- 
// Casey (she/they)


