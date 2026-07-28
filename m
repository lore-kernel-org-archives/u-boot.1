Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC9AC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:31:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C62ED8127E;
	Tue, 28 Jul 2026 12:31:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ibJara6L1tZm; Tue, 28 Jul 2026 12:31:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47EB780F14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241895;
	bh=UHGof37JV2at6OXHDSCdzFX6ABDKSfrL4AtnFs0HWTI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e6NlwM6lmheC7wlfDdNIKEsGYD3BWbH5W+lk6jL2ej7IqKN3EJjgrixBLEazuoHIn
	 RwTGMYIxtr8ELmhjQV+mA2j+hfZIpX0x2ZLYajD8tSUnmfllsZiOSue0wqwAyjpIKb
	 XcSxNiJOUX4Pfkt1gvgVjZMEZ8Sht4+RPa23TmUkNaX7mR2XYNtHzHmm47gjNah6YZ
	 nh70SbE5Kh50YYkPw7/fAMzmjwQ/CGKQmowfNpvUZm6W2T4mwMjp+OLVGw7HJGCw6R
	 bks108dRl06uyreX39YDSuGzNNRNrmATly57arkI5I5RAQrFuoQI2H1vS5ypjhE8/k
	 kCB0/tZ4f54KA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47EB780F14;
	Tue, 28 Jul 2026 12:31:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E7242E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:31:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6036160856
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:31:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BEkCUBPy1ulC for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:31:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DF5FB607ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF5FB607ED
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF5FB607ED
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:31:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C728F8494B; Tue, 28 Jul 2026 14:31:30 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D665F82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 14:31:28 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso25964065e9.1
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 05:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241888; x=1785846688;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UHGof37JV2at6OXHDSCdzFX6ABDKSfrL4AtnFs0HWTI=;
 b=Ixy5XHb6VdvIl3mjOgTtLLHHLc9+6t9SBmvlaZ9Jj6UFbl1u8Ba9zPsmVO8kajLZOy
 W1efKkf6uQrEl5nm5W22Ae/eyWhntkC+lpFLyi4kNME266jUX6jTeYDw6UU+6PNH3Ehw
 nvYsegAp01XecD4BGRwXEHgKeVHzXkwwQeJy6p/2zBupap/57McyU2B/ZOo6gfu0XOax
 LkE30GMdio6tKKCoeBgof3r3h3xjSRrB87972G8BRrwkmNITD+aZcR9I3ywsDLKIHa7v
 hitcWpxfOQvosQlwWCzyr8PYLTQ50OxHq07j67k0ODwWrkQ1FPepkPJmYLIUhYRXQC0Z
 R2JA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHFsTJoxdLEfRKAscshjjh6ferSHTZNbHwbK/MjlYTLNHhcdcTjzfH+hp4QIYBjiKxk3Ip5MM=@lists.denx.de
X-Gm-Message-State: AOJu0YzqKCEavNXvzSIHPIdoTSoiyAjfM7pfdVxLv972mqrgF+nPhHEV
 asTzsytwHax5btevPMdxhrcnchz+QF0C9M9cVoHdg1B69v3KQViRkdAvV1iug4aXruM=
X-Gm-Gg: AR+sD133yBU7Qny7HbOwZKTKAQkIecz2gSZpOV9bLPwpfgmGyN9Bj2jNV67uhwEWncd
 04x+A70MKxvLDizpYMy7fcSXfHmRDSIQ8O0vrQJAHHCIDZ8tFFnldRv0YxebIQQod7+Dmfoy2uT
 BW06v3uBlubweiHk+WMXQZijCa2mus1AFvxlNyvYKB7XQ+EeiCqQLT0IRem3A2ZvKVqa3svnffk
 j+at5vg00+T1ARC5tpw/oyFQd0oVUvjV1ZGJzFrreO0qhpn1ZZegOphDRuEDpEuyJ+2ijJavRTe
 HK5DDNV6DfzLmVvrwbMVd1YQOWtVVhK7SlgfuniwusrEtKd/YHjBwwn2U3UhknVlCx4BIhKt9MA
 zy+qMYVcjbPsAxqHsgbhPKYNRA48mKKsnZUEwVs+U4JbuNIysaVHuxSFR6EQbpcBiZ9me2s8kNI
 0UMli7tgPYR1yxZH36KZSQCW70+mCebkIx/LyvWEjDXKdhOVN9KXo3
X-Received: by 2002:a05:600c:4745:b0:493:bfad:9d99 with SMTP id
 5b1f17b1804b1-496c643be3amr26987485e9.13.1785241888157; 
 Tue, 28 Jul 2026 05:31:28 -0700 (PDT)
Received: from [192.168.1.37] (p549d460b.dip0.t-ipconnect.de. [84.157.70.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c52fc0sm58140277f8f.23.2026.07.28.05.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 05:31:26 -0700 (PDT)
Message-ID: <a7886449-9d39-4fc9-8b3f-416fd702e102@linaro.org>
Date: Tue, 28 Jul 2026 14:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/12] Add SPL support for Qualcomm platforms, starting
 with sdm845
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, michael.srba@seznam.cz,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20260521-qcom_spl-v9-0-c108ebe8ff4e@seznam.cz>
 <da0a76c2-6725-4737-93e3-9cd933f87b4a@linaro.org>
 <95ea4b4b-3660-42e5-938b-6a029b2e9ac2@amd.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <95ea4b4b-3660-42e5-938b-6a029b2e9ac2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241888; x=1785846688; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UHGof37JV2at6OXHDSCdzFX6ABDKSfrL4AtnFs0HWTI=;
 b=PVI5c6bDnblXkSEY0vujQP/v2pO5btDQ5D+wQGbcTHYfkfyMcJKA/DDpkvPfrTixU4
 JubbmEzSIc4iR9XdImQ1jXPFEUQUs7FnkVjkQXncqTc5uA3wIBAReidTASmgq2QB+dlv
 KEcp+hdl+MbWip2fXgd2bLiwDDgoVPSZb/jRxB6j/7IWEQh2sv5nhftW0wL96AhBpJTP
 hlPdIePxu1HvIr5X9My89w4am9cG0Sgmri+QLdZiC2ZhtauhpT92egMXD6HeaS0YeqXH
 AEo7I7pPiXeJoQ8mjvogzS1R9alXv795HEUM0EKGFYKi12yCXscELIMKXSbHWavsH8hX
 LSjA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=PVI5c6bD
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="PVI5c6bD"; 
 dkim-atps=neutral
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

Hi Michal,

On 28/07/2026 07:10, Michal Simek wrote:
> Hi Casey,
> 
> On 6/30/26 08:53, Casey Connolly wrote:
>> Hi Michael,
>>
>> Thanks for taking the time to respin this and get it into shape! LGTM
>>
>> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
>>
>> I'll pick this through the Qualcomm tree unless there are any
>> objections to that from other Custodians.
>>
>> Kind regards,
>> // Casey
> When are you going to send pull request with this series?
> I would like to see 1/12 applied.

apologies, ran into a few CI issues which I'm working through, should be
out today/tomorrow.

Thanks,
> 
> Thanks,
> Michal

-- 
// Casey (she/her)

