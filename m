Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC71C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 21:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50CF84068F;
	Tue, 15 Sep 2026 21:59:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hyt_Ky_clW37; Tue, 15 Sep 2026 21:59:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9476B4064E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789509563;
	b=AuDFGS7Cdul4EgoQEaIZ6zEoTnJY9RnxZQTlZgPs6AjXiBrDNj8na6WPkJYofkNDjbfj
	 UyAyxctZ3rHYdD8Fhzax84zhmgbm7dIolcoy0lwxAv97/MVFHwTYCrL8KZPIAfHm7zCZG
	 BZ29RP0b/1rSYmZ0rTeE61qD48zM00TrlHlDgyZrbJIHfpamj9lNOLUTctWpFDSg8xsLJ
	 pntBfuTSovrq8yd1e+0lopiTBANe52DQwg+quAXXvjBxLiyVts2sEyAWH7tAMB/5vy/s8
	 JqFekRDhKdapJa88B9FcOBRRjquub35URAFluKYLGpGQMFjFYn7bJAxWcwfqUnPorXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789509563;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6xEBcIqWHegsNaqfMq7GBBPmkF3K704WEIBuIKUNs18=;
	b=HycXINV+4HBpNnwrHurqSq8cVT4DiZDrjEvU9JdOVowG/XS3W8JeOxcvJf+DbehZOh4m
	 hWZWa2HyiIMH2yq2TEeAsA9pFpJxYmO4pHQdxcH/tgfF89ydVl3kfxa+71V6bGInLMjp0
	 jqXxyZzN22vHgMbMIxaO8VMIAdLAUQpCtON3UCd7O1p04tsIYDsMxpkAgxkIsgofSdvrA
	 R68zXoXQtI6HRpxGZrt7CM1Dimrt9NBPq6i7CJUPMpRlo6osmrRlQ/6PfFDQ7Eud42yhh
	 wwpX8c/03rhqunOvo5iPHe0o3w38D9LdunZfmgKKosfH8CsQkkfxTy7loza2T6s9g4A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789509563;
	bh=6xEBcIqWHegsNaqfMq7GBBPmkF3K704WEIBuIKUNs18=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VQpuMPh0BbwxZsJ9ppP1MwqoyfFni+X0Y+bwsTPCQZ6K9coRhH5rOOs3YLMAdF8lQ
	 wrtyrXcuMlX33mou9I0mUOt1z8JJ/0e6KqUVf1oDha8fw2Fz5LkjJSdKOV99aoWNsE
	 D/K64Cvw+8QRUfqWBckaCXgAAqQ12g7rAtNKLyw4otGbiPeYUQ4RupTs7qhtWi80ze
	 7Kd5sOi0M6o4PsgmiGNPInVoXKb1BfjyElrbaYmewQIFlTkMXb1Lwp7iYQTTKzoA0g
	 fOEWEJb+5CGBe1X8l8J3t/Gfw9nlo6fhmB9RLnBF+YPQGFrU0c3nmxxgRNSZqI6WYe
	 hy9t6CLzWG2wQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9476B4064E;
	Tue, 15 Sep 2026 21:59:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EFAF6352
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 21:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D5A5940248
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 21:59:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LAWqdSW84BFl for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 21:59:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 38C4D4008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789509562;
 b=pwGZkkeHvsx42T7pz5Vc5/oRHwzlQvS1oG1k/zK4EeGju+Z22RGQlEMYfJfQszleCcdE
 H2hdO6nQPcx4TV4N3BlGDg/X2LszenJ3eE/Q1NTH4Lek2ZiPGD9f4Fpb7mSxbdSi+/6BV
 PI6QI4vkphTSI+js/dTvkO+PJIERgaTD9TIX5d9E7cvzwXxI55ZlOqbzrp5Vg9GhrC/xJ
 vGEN39WMF40JK+63X0HTalVuGhMvpiXr+lHNeirkqzT3ukK3aiJIH6moJFBRsGlPoPcRD
 shZOSzhINAjw4tSZFR9LZfdW2BaYM3THPwX8zcQvIgdqnlDlar//w9EuLASKiiR1yZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789509562;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=6xEBcIqWHegsNaqfMq7GBBPmkF3K704WEIBuIKUNs18=;
 b=EPZlszjkgYCItgRPFEQLuPwXj79bRHPdFl/rGk/URJE4HjPLWtHbjfQYF6h3XisvhAGS
 aciOHtFiajq43jo8MSZWk0BEJBm6L9zVLoLkeFCZi9E7AqKsl2mzIAUbOseQGABlp2u0g
 eh7Ess0dALL3rlqrB5vVyJpPhW8dCOma+2CGqEVC3Q+XNR9SxYQ9YU7EECRtN/L8l4Knq
 vCysDAZl0MGSWcNBeZlVGNFHFdBJ2KDxz5c1wXeD2TbzWfHWh23Vh6tZUi9XDRQrvpD1U
 uZ7s1YeisdVQ/Adr8pJW/dr5LSXW0Lk4zyO5Hm6gn6XhRWqGCqx97bXlxcBKQrYKO6Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=F2mWimsQ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=F2mWimsQ
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38C4D4008C
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 21:59:21 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-80a18990c76so161797a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 14:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789509560; x=1790114360;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6xEBcIqWHegsNaqfMq7GBBPmkF3K704WEIBuIKUNs18=;
 b=F2mWimsQpyMU6d9PMHpH0wN5igcC2hHRzX6+vNT02rjhR5gVwdWcugoHeCK4Y4VXoY
 0PZMVN2fVpQSSGu/xDmBwguoXnEvWSP8s+oUHM3v5G9WhTxbFbpD3bjjKr62GHjhj6gl
 SdvkUTDvbO/kvbKkMw+PTNY6/Nzfk1hMlPQW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789509560; x=1790114360;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6xEBcIqWHegsNaqfMq7GBBPmkF3K704WEIBuIKUNs18=;
 b=isWLkA0S/4Z9/9eZuqO9am6zMNmoxe6YfwT6VsEyGlSKJcn3ZQhiSeAc9jNMYISNVg
 kmU1KZWRis6VaWem+kmE/lp1EudJoDnj1JL8CxCS5HZpbmw6rL9dvpEz9mA9fGgwZgwe
 AZXDuCEMWho6K9hxSKbUAD5pZ8DRgEZwOKJMVpOX+zB28dzkro7RpU+OR8lrzd5no+Po
 3mL29RrGdzU2YzBsfVSLbocaOJWvt3ZM9ie4b9MXdoj4LwFAR9YeLki39x6a1CDmZw6T
 JfvmGJ9Usuy3x+N3CNaTT0oJFAny2iq6S6lNs38CCLmMXKdxQW3XGDdYeTFJBRe9WAQA
 9EHA==
X-Gm-Message-State: AFuF++ntGRDD+TIiUcniDjjbjBGFNYaSYKQx7SRGWx/0mbJvEyXEIboq
 aJvD04Oe72Ioq/Y63VBXpAOD2EIujb3bDKKIhRiRYM3CfKz58rDOL2Se6pVEpFoKG0YBVS+xymS
 lD2A25kDA3cc+
X-Gm-Gg: AYBFou0uhIHcreKMpoOAtcpKNyxK0ZCN5ptIy/4t/MunxJyz6Hqyg3PzK3A2M2hIQ0S
 +to23tGE8Faao1yrY8Y82pHY3rZ3BF0N0mM5NfXNTBR1ioCUta/dQPJrrIgwIB1g6NvfSPADxcm
 N+ZWZVnORreivJNqYHaX/7r3rLM8qaPF5lNaK2yFiNXqsEs5PUp/zKdhmjfD7vKE09jOZKOu4C9
 NyNhZmbT3gOj47bg42UKWjIqzolhEOKYoZfbnAPYOBCOi6WuXTqlabE9qrm1ZdGXhYUcOXmXjKK
 MVvPmeODnil9e6Z8zbNdUeyBmEk4KtF4XtSx7yx9xc0ofWBGa5a0YHdrBJkkL8fvt5Edt6wKpwc
 RcLzToktfZOQTI954067+eABqtE6l4spu34ISp1m0XDn6GzuAeMxouJlzuRzxYEZXYWdYwxLm75
 0MFvmt64OZdFAyQBS8PwkdVhYyzKEkYROgrQy8IWW4+fi51X1w5h1HG0EnX5AWMXfzxmx8mbswI
 ERsoU7B8C5aAHQIvO9OJftVrZISBpV12T3QTo3Q2TBNma2HDtK+VO/qiv57Ps4G209DY0hpGbJp
 HNGJPW8vO/0Z84x1L68=
X-Received: by 2002:a05:6830:7187:b0:806:fca6:f3d with SMTP id
 46e09a7af769-80b2f5c5a24mr534153a34.15.1789509560551; 
 Tue, 15 Sep 2026 14:59:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80b07ad0506sm646957a34.27.2026.09.15.14.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 14:59:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260901235947.350315-1-marek.vasut+renesas@mailbox.org>
References: <20260901235947.350315-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] cmd: smccc: Implement SMCCC 1.2 support
Message-Id: <178950955992.949220.8444224074008875162.b4-ty@konsulko.com>
Date: Tue, 15 Sep 2026 15:59:19 -0600
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

On Wed, 02 Sep 2026 01:58:59 +0200, Marek Vasut wrote:

> Introduce command "smc64" available on ARM64 only, which uses SMCCC 1.2
> to exchange up to 18 registers between caller and callee. This is useful
> when interacting with e.g. Hafnium or OPTEE-OS via FFA.
> 
> 

Applied to u-boot/next, thanks!

[1/1] cmd: smccc: Implement SMCCC 1.2 support
      commit: 826ac8d2dc500fcc780647357032fea493e1f9bb
-- 
Tom


