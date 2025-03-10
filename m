Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA78C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 21:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7931780107;
	Mon, 10 Mar 2025 22:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741640920;
	bh=Z814i+XXL2ZauzJMvllx4US1R1Mcits5KRAjEC7elk4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sTAKmzyiJkDb5Ss4x9SAAObiqD0QRPg6vcGIqKlEjWswKIGB/54kGOrBwfs1JcnTq
	 NpRcvzMfXKYEuM8narANQrqHxjW1H0jMbanOG4jvO4ubkbUs3aLQyQP27poKc7FkVc
	 evy0XNqt+Oy2swAudqYZ8r4qBj9XB24ynao8ExXwN80IGpfu2KejZWfPMdLdiSalYR
	 y3QTqqW4O08e5GYAJlfIyanYWM7aO5JfIVbNDuPiaFIi2pHlm5iz21J8QxmOwZUPym
	 eITD29nHQCbd70tCgkQSBQYVzkSSTeP23MHOYjKPUAZ1HVYwJeIvwXudOIDjSnTCdq
	 JFwrqjxOojZuQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8485E800D7; Mon, 10 Mar 2025 22:08:37 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E79108164E
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 22:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="VF76s7Cj"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1E3AF1020CACD; Mon, 10 Mar 2025 22:08:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741640912; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Z814i+XXL2ZauzJMvllx4US1R1Mcits5KRAjEC7elk4=;
 b=VF76s7CjaK47db5YDJYZyiSfOyDrUlPwqO0ZaX/8AvwK9ryHPDfFlYalvg8ULnPk/dTuNo
 QHmUl0cFmEUw9BOMQcLL3ys2VaKbQk4Steimk6X2KQXXjiuudm+QvJVucQvZXidJQDfXbj
 aZkzy0FAF1U8gUDdYmCp1lR9tlZ1gyEOakESSYp2PWCecATRqAdhruNEDMcPMvHuefwClb
 xgjyKrF/yVCddlcgfrIKZXmIDUulYt/RoNBOFy+q99VJJ7l8rpwp0R7B77LHDLrAQgRhvJ
 iEe4Np9BMQCBlIOHRTLDJ1bNE7SHj5WsbtnootHyy5Aj8palfgfXWlllyo/aEw==
Message-ID: <20442227-eb4d-49a3-8401-9031d818c91a@denx.de>
Date: Mon, 10 Mar 2025 22:07:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] pytest: requirements.txt: Include setuptools
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-12-marex@denx.de>
 <20250310135557.GW2640854@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250310135557.GW2640854@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/10/25 2:55 PM, Tom Rini wrote:
> On Sat, Mar 08, 2025 at 09:12:15PM +0100, Marek Vasut wrote:
> 
>> This seems to be needed for filesystem tests at least on
>> ubuntu 22.04 machines. Add setuptools into requirements.txt .
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Baruch Siach <baruch@tkos.co.il>
>> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Hiago De Franco <hiago.franco@toradex.com>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Nam Cao <namcao@linutronix.de>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   test/py/requirements.txt | 1 +
>>   1 file changed, 1 insertion(+)
> 
> This belongs in the requirements.txt for the tool that requires
> setuptools, not pytest. It's also listed as a required host tool /
> package in doc/builds/gcc.rst. Having just re-created the
> requirements.txt file, I don't want to add things that will get dropped
> again the next time.

This seems to come from pylibfdt . I can drop this patch too.
