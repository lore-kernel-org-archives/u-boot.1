Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351FFCA600B
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 12:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E76748121B;
	Thu,  8 Oct 2026 12:46:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fuYGzTZ-D7Hk; Thu,  8 Oct 2026 12:46:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F210F81283
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791463581;
	b=DIVophatS+JS/RL4uNll4QCMPJxOkKAIzqxmSPYVIGZB+hw2q28cuM+6Q7ifw/n4V3HI
	 ylcqtn4LsgaA3g8hQlcEZyAHsyr0I7EMJJWM2bz9LpC5lKlmkHIQ3irOGXmwDW9U90z8B
	 vAhd/2OIEufBHCZLZzQ2gXxbOYrM6c3fiCsb5Hs5KFto92jTaiZ69KI7mhgdSJMpAi97K
	 dlmq1P6Rgo2M0d7A+HQ2OKDIO3RsHfOd39dowhVGaJwLPDAFRl6JEK0LYzvrAr/sCv9xj
	 bJLJbhfamhwN97yJ/gPw7etWKpKGzFDIfHarrLs+aK4K6CXn39OtFlJ9shtW/8rkS/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791463581;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=mUjeBvKQoHp3KF6Il3orO20Bhd5dhm74ocZFNS+U4P8=;
	b=F/kBVGyN/CxAluYCDibsKzwndG+Y8HGqz/v5YNeHyvxfQRDwcyiWzqGwO7WtHw8P/SiW
	 OzNTztp4tDpKhbtXhQvRA30UZnc9hmtuPAYOXio0M3f1EkzRrrFILR6BFz0X5VSMpsCUV
	 YdF/k6cS5dx4sSMp4nc+MbUP0sqMFoMI/LZ3QjHptY0NT8L9lsLLmoikZGw8JyFfxFebQ
	 P6nHfY4QSDlE923TaDERD03bgfEdz2stHK/oyXfC7fNxz6QSPq8F9NPov1IqaPsTTtEf3
	 QV0Z7CVVpvsgHo3284mQWcx2C3LbC2fTALay4WaPDX5abR/MtfMQOooEJRLqCXZnKOw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791463581;
	bh=mUjeBvKQoHp3KF6Il3orO20Bhd5dhm74ocZFNS+U4P8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fm4lyg+MBR7wvK/DE2wDyHZHzU78BXBGAXO4EX93OP7Oybcg2Ps2JEjj0mhJ7B3fQ
	 1MNlYVuYNA/jpMYsPceppZK6/MxmVQ5RdqlcSjCqnuvk3KQKzJo+vrPmptICD0RHGv
	 SO4HRUDqu8y3eV7mCJdF2ZG5HTUzSTJEa/2auAoz+eTUKbw5X3R5q3MnIwm/kilCQA
	 CHvNijH984SxMbJVoV2ltrq2ASKUhNQ2m/8Yso1qwZ5gr0Cj5Dk0XsO3Eeomr4xWrD
	 m0ElgoH0J1VpQZYLjkNqw9i6EG2KUQZ/lSjd0/IZWC61SLz2HE18R0mpy+tPBFavcV
	 d2D8/OHIU8++g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F210F81283;
	Thu,  8 Oct 2026 12:46:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 558D934E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4732760B39
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t54PphwdVz_3 for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 12:46:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4435E6076D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791463578;
 b=eut5KHN28L0HHirqDVZoJzHl68NYLFejNDabx8cdFsCszds/m3GtAFfVh8PE/w+4Mbut
 dJWxjzwDx+/qIaiXHJn8yk7Grwyesy6XOCLzNxtENl89sVIk62sfBKWpoLl4+ODX2QSpW
 D1k6o3ypJDrAEd3LJonfUOncdjcsYxkGUJxh2owvibxofX7s4b48T8cf0yMBZt9lbLTti
 qDHIPPA5g5WiVzh8af9yzlGnx8ONgTDM/1Lf6mKEHobd/h6BBxHC1pXcZKDG7iqUyPPLh
 IqRVJ8nibidf4xOmZlmv0389BaYqsZI3/ISps+nWjtuQOdffn0pZBO8HzBnmUIIH4fQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791463578;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=mUjeBvKQoHp3KF6Il3orO20Bhd5dhm74ocZFNS+U4P8=;
 b=I4jK4IQTozUZhnjhxTxlGIa5ftyGTamnlQ0TGiY4YGpDdnDlycY++QlM5XnFPscAv7fp
 x3U82BPnjMUKpx4yYFUfUM/uyqFkwQ4EVriAWekVT9zRAmNXlumaqVI+t1DRI5IooPx5+
 6aQyBn53fplR82LC0NAAhMpCvENtwupuhM/BT6ul8ElVf8I/TVLG7a7ug/TGwDYdHEVzf
 MBpcY7WHSn9iFSKIhGvVWLhPnEyCDDmFx7LtGiwd3YIY4j+4c2cS6TooSUHpRWn7vHbxw
 y71RvpvTTuXWgd1/AGj8QZkQagt2nwh62aUGcMXN90cWPJC7WJGDM5jF/7tHdU+rUwg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tAqxtD5Y; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=tAqxtD5Y
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4435E6076D
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:17 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48afe75f055so4730590f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 05:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791463576; x=1792068376;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mUjeBvKQoHp3KF6Il3orO20Bhd5dhm74ocZFNS+U4P8=;
 b=tAqxtD5YMhPDvqeKY5WtYoJLPA3maM5wcMaj5mV5+IcgcnCT8zWFJPl1AKSgSBwu63
 I+eBpZialPsoxyur5oOzLuoKwkmM6YMgtmXClLYYRskc2UM/+/+eqcNPgKcACjeb73rG
 R3Iud8hQ3Hjc5c/slsQM0of9VXHtxUeitZL6f1VUzhhNATZ/4DIgSN+jAK7vVoGn5WgQ
 EKYtq1+XFJXcEIQx7CuQuK5GOtTI6ZRFNtR0VxcEAh6GEBtzxzRWaFN36jZi+mlO9mYc
 K7qPz/A/Thr50xRqwykB04BOYEYVSDTZCbvSjA2+4vGy7KcyV7EPsfUAyFo9fjMnmJVv
 0zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791463576; x=1792068376;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mUjeBvKQoHp3KF6Il3orO20Bhd5dhm74ocZFNS+U4P8=;
 b=l8teOJ2bATcVcNQs96cU4vq66AAhj1K+KM3SiBgwgFG4uZM6M317xuW5cyGZpF+lXw
 6ZfDd6t2A9pVe0ydPhfFHH0QokjUX+uYPCvLzTRPcHaJnjwksLCPkl9Anep3l31I3TmE
 qLONINzPF1QblWBwzzy88MukLyUilif+w4lS7BP3AqZUe1w+tzd65CuGNM4V2vxQnvuu
 JJkdpfTnHPybjO8Ycq65PPIluVpEcgnC3EXDg/+D3qYxhZXmJynz2IYEJLrI9uf5Uz5k
 BcZTFQvHWPnPecs6a1R3PU60Vio4uqfYoGg2rofhZKWNH/WCH2LuAdEBMPDAo5mYzqrJ
 88DQ==
X-Gm-Message-State: AFq9FYKI4pAY2RR6Xn94Qr9t619lO4vB9WJY06HpEQRKYwXks03XqfPH
 rSp/rFluD9iVjmlCkAI2epFr/AReUKDKx1kxw+obpeCPhKdj5WBRFOQzthJ/b8bd+UI=
X-Gm-Gg: AYBFou1jL+FaryFdi3B4fnRNKrqQw8nqpwX7vhVNhr+BPS3vHCGYtG+/9fU4ytAogSR
 efnBIroZTcuVEauxL6B+drQLshwzibLscRp3FKfRJJLYmk79IHhPYGZeALb5yBK0f7ItofWmTjA
 u0g6EqjMZy2itucFbcNH88gBxPN82DDOanq9aYrbOVd+AkACNLfU+4DtqcLHdeycU/uc/KEV1sD
 Wi+GJwS/651NUu+RBSG//JM3JCN4B+ZEdvYOqRcTABHp75jxCc2zQe7ZoDvyvY/7jIX7xizNz8h
 TUcBPDc5aM3A2byCk6BdTUGEiRY+CnEjv4FgLDpGOvlpcAYnCl4AwAoZ53q5d0UT3NYaXbaIGse
 mddZXvsftXCJAiuzRz5XJanWt1bOHdxXw5v6J8skyHMXYd+OSw7qW2SXriLtzN+Eo2cu0i/YSde
 INWOHOls24Udeo7sHTs+XJH9NpAeQp82KDiSfqpbBo2fYp8cijwnz7nLTj3Q21WL3UKovFLJM88
 3KrwammaWKsLyYhkUJE76UnIyzzwOM=
X-Received: by 2002:a05:6000:989:b0:48c:6955:a603 with SMTP id
 ffacd0b85a97d-48c7278fd23mr9553770f8f.13.1791463573840; 
 Thu, 08 Oct 2026 05:46:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d04c0fsm11015183f8f.10.2026.10.08.05.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 05:46:12 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.u-boot-project.org, Sean Anderson <sanderson@brivo.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20260824132518.522252-1-sanderson@brivo.com>
References: <20260824132518.522252-1-sanderson@brivo.com>
Subject: Re: [PATCH v2] mmc: meson: Parse devicetree properties
Message-Id: <179146357210.183177.3661541259972957816.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:46:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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

Hi,

On Mon, 24 Aug 2026 09:25:05 -0400, Sean Anderson wrote:
> Parse devicetree properties so things like max-frequency are respected.

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] mmc: meson: Parse devicetree properties
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/f7e3eaebd300a0e2afdefc54a5c5ed6cb35e5aa9

-- 
Neil

