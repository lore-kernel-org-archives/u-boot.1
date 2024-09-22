Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C7CCF9C69
	for <u-boot@archiver.kernel.org>; Sun, 22 Sep 2024 21:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FE0A88C71;
	Sun, 22 Sep 2024 23:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727041314;
	bh=YyCzBoS1FyWYhBC/JSy1WIuUQW5ZurzI+bPdMDx2Hss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mS4bDp+DFqBV8M5bzA+jGKSWrUnRmjcutbNbhTIQmHl9oburdH4YxoxuNpqD271Ij
	 4wz8WBKeVXZeb0PWtFtrArBNh/KvOVZ5ewT+Sg5/jGMKlwWFtH85RWU8Pj8Zf8wsCS
	 0KCJv55S0CNc+6+g0MTnFXBRjnlyfNRioLhFtEWnxxIZU2nNxzykSxUMB/P8g+yxi6
	 CPgs//DjbAY5ceqhjqxDLdZ4GhbZ/10fZC0e2u7y/p4iNRPPjtnxmKjIq4YBK0b33O
	 DOqR6/dNr7e+O11RpJdfLnoW1K8KDZyd9eOrqNHqT8/QAE6VhgEMqweFOjm395pe3+
	 k+pI6CGeA3MxA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6A1BE88B3F;
 Sun, 22 Sep 2024 23:41:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727041313;
 bh=YyCzBoS1FyWYhBC/JSy1WIuUQW5ZurzI+bPdMDx2Hss=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OCNZXmfzqlKB1KRELiuVvMWTiPcoOV4SNqqBYs2Ai9wKAZMU3jMOgnOhXR09rC3iQ
 Tr1jHvpLyQDSxB/JjkCE/auUI+CtA7nq9w4tqrkZrTqv2vO/142bqmSX0q3QfX+cB+
 p7Mp06Nw+YYKKdV/312G4LRVy6a7+d9TEOJt337MTo8JztyUAilw0sxEDtyUfwt0Tg
 sLvN0Kb7WDJ9P9DMKvQxANZnQhxl8KQMpTQQ1e9r4IVcoqnwLQF0YIO3avriis083X
 b42CTb1fWkk+JyK17YR2jIBZJdrf4ykeWipPPbYl1dlkEQesmcFpA0m6TeyWjZcP5O
 kdxIi/qunJfkg==
Message-ID: <3388b4a9-6380-4a7d-b779-31c381c80ee6@denx.de>
Date: Sun, 22 Sep 2024 23:11:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] add support for Enclustra Mercury AA1 SoMs
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
References: <20240917062157.3181-1-l.rubusch@gmail.com>
 <87b42397-6eb5-42a4-81a1-5008142d293b@denx.de>
 <CAFXKEHZ3i=Fk52s7xhSoP6xWyfwL0bs+waCy3bjgpducYJ-Pcw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFXKEHZ3i=Fk52s7xhSoP6xWyfwL0bs+waCy3bjgpducYJ-Pcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/22/24 9:20 PM, Lothar Rubusch wrote:
> On Sun, Sep 22, 2024 at 5:33 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 9/17/24 8:21 AM, Lothar Rubusch wrote:
>>> Introduce the support for three variants of Enclustra's Intel Mercury AA1 (with
>>> Intel Arria10) SoMs and additional configs. This is supposed to be the first
>>> step to upstream several of Enclustras SoC FPGA Modules. There are still things
>>> to be modified. So, this is supposed to start the discussion and also to
>>> clarify some of my open issues.
>>>
>>> On the DT approach: I can agree that in parallel I may go for upstreaming
>>> the kernel DT. There is a fundamental difference, still: In order to
>>> represent the combination of module + baseboard + bootmode for the kernel
>>> DT we have to use a mechanism like DTO. For u-boot this can be simpler.
>>> Currently the few adjustments needed will be represented by the DT files as
>>> are. I propose to keep them, and in case remove them later, which I doubt,
>>> since the full DT for the kernel will cover more details. In case
>>> refactoring is needed I can update the DT also in u-boot.
>> I assume after the LPC discussion, there will be a V3 ?
> 
> Yes.
> 
> V3 affects mainly the DT question. As of the LPC discussions I had,
> currently I'm about to rework the DT material. The material will need
> to pass dtbs_check/dtschema.

Indeed, that's a good thing.

> Functionality then needs to be verified
> on my hardware zoo, and eventually I upstream it directly to the Linux
> kernel ML. If successful, then, in u-boot I will build up on upstream
> DTs as proposed here initially.

Thank you.

> V2: Please, feel free to already review V2 patch set. As I assume
> still some issues. Alternatively, we do this on the V3 patch set. No
> stress! Every feedback here is highly appreciate!!
> 
> I pretend putting the involved u-boot people here in CC on the kernel
> ML. Pls, let me know if I need to do the u-boot ML in CC as well.

CC is a good idea.
