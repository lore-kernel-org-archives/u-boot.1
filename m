Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFA0CD4F24
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 16:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BE9B838BB;
	Tue, 12 May 2026 18:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="ElwT6O9b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF9A18394E; Tue, 12 May 2026 14:44:12 +0200 (CEST)
Received: from mxd-3-705.seznam.cz (mxd-3-705.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:705])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B755D801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 14:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-7994f94c68-kzzv6
 (smtpc-mxd-7994f94c68-kzzv6 [2a02:598:96:8a00::1200:705])
 id 145331044f5d656d15fafd5a; Tue, 12 May 2026 14:43:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778589832; bh=dzODJxgN/5eUofBYkp2jirBQ4iZuLC9HJspYrP/21eQ=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=ElwT6O9b3RvHF3W2lGpggg2BXuAXBh1UNl+nkNwrIlGAAG5eMi6oU1di1psaQWT4A
 LubvAQa0LogmpNC+/WR7uKR8loWdmwiST15dJjWB2J9IPU0cqIPlPcF9X1NPjIX//o
 nQ2A2/Q2iCF6/UOCyuTU4T0BQLWO74EAJGTEDAhqSSYW04xTWNPGOzSv2ihQmbSu4p
 XNwoQCYqeykInyqxRP+fY5XZjvLpS1yz4r5KF30iRV87pIHK5dixYKslnflfoNp07T
 +BthHEpcZo4QVuyefgN/XfaT1ubsEHZ0LRCERkUh6U3hM9a4WBUM8jdNn7k92o5Kmv
 KLpyIZruDiKGw==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-f997798f4-5q5rt (szn-email-smtpd/2.0.72) with ESMTPA
 id 83247dc3-534d-4e65-ac68-3f19d8f8f6c4;
 Tue, 12 May 2026 14:43:27 +0200
Message-ID: <733ba7cc-cbcf-473a-aa31-22b673982702@seznam.cz>
Date: Tue, 12 May 2026 14:43:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/11] mach-snapdragon: add board_spl.c and split out
 common code
To: Sumit Garg <sumit.garg@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20260508-qcom_spl-v7-0-7d0e22aaaa8f@seznam.cz>
 <20260508-qcom_spl-v7-9-7d0e22aaaa8f@seznam.cz>
 <d965e291-51eb-4120-8740-1f14d739bc5c@linaro.org>
 <6bc4f999-b37f-4961-9bed-17d45e1b77ac@seznam.cz>
 <85e696ff-e66c-4cd3-92d7-61edfe6493ab@linaro.org>
 <agK1zQWeFmaEfs-J@sumit-xelite>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <agK1zQWeFmaEfs-J@sumit-xelite>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 12 May 2026 18:11:03 +0200
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

Hi,

On 5/12/26 07:08, Sumit Garg wrote:
> + Varda
>
> Hi Casey,
>
> On Mon, May 11, 2026 at 04:00:46PM +0200, Casey Connolly wrote:
>>
>> On 11/05/2026 15:55, Michael Srba wrote:
>>>
>>> On 5/11/26 15:33, Casey Connolly wrote:
>>>> Hi Michael,
>>>>
>>>> On 08/05/2026 23:45, michael.srba@seznam.cz wrote:
>>>>> From: Michael Srba <Michael.Srba@seznam.cz>
>>>>>
>>>>> Code in board.c will now only be compiled into U-Boot proper,
>>>>> and the new board_spl.c will only be built into SPL.
>>>>> Code in board_common.c is common to both phases.
>>>>>
>>>>> Also split out mem_map.c, which is currently common to both
>>>>> phases since it seems to not cause issues in SPL. In the future
>>>>> it should probably behave differenly in SPL, especially if dram
>>>>> initialization is supported.
>>>> Sorry to be a pest with this one, could you rebase this on the SMEM
>>>> series since it also pulls out all the memory mapping stuff.
>>>>
>>>> Since the only thing you left in board_common.c is the board_usb_init(),
>>>> it seems like it's only actually used in db410c at least according to a
>>>> quick grep. Could you just move it over to board/qualcomm/
>>>> dragonboard410c?
>>>>
>>>> Along with the other changes maybe most of the contents of board_spl.c
>>>> should go into some board/qualcomm/sdm845-spl/board.c file or something?
>>> but there's nothing sdm845-specific about it? SPL won't ever be passed
>>> dt by a previous stage, empty board-init is a sensible default even
>>> if someone wants to override it in specific cases, reset-cpu is a stub and
>>> if qcom wants to implement it there's no good reason to use PSCI for that
>>> so it can be universal (though an ifdef for the non-typical case
>>> of late-in-the-chain SPL would probably still be cleaner than multiple
>>> separate board.c files), and fully implemented spl_boot_device should check
>>> what medium the BROM booted from (or at least if it was EDL, which is
>>> in a hw register, not sure if emmc vs ufs vs sdcard vs spi needs awareness
>>> of data passed from PBL), so again can be perfectly shared.
>>> If DFU is not enabled in config then the USB boot branch can even
>>> be ifdef'd away at compile time.
>> Alright, I'm a bit unsure how Qualcomm want to base their stuff on top
>> so I'll defer to you and we can keep this as-is. fwiw the "sdm845-spl"
>> naming is just arbitrary, if you can pick a better name please do.
>>
>> Sumit: any thoughts on how to align these approaches and keep it all
>> maintainable?
> Yeah I earlier asked Michael and Varda to converge on common Qcom SPL
> architecture which can be used across SoCs.
>
> Basically how I think the way forward here would be to have a common
> Qcom SPL architecture which would then have the platform specific hooks
> for functionality currently supported by that platform. Once more
> platforms try to use the same functionality then we can migrate that to
> common code.
>
> Looking at Michael's series, I think it's mostly doing the base
> infrastructure SPL setup without much boot functionality added. So we
> should be able to merge that once it's rebased on your SMEM patch-set.
> Then Varda should be able to rebase the IPQ series on top of it. I think
> the QCLIB blob loading for DRAM setup can be a platform specific hook in
> the common SPL code overriden for IPQ platform for now.
>
> Michael, Varda,
>
> Let us know if there are any concerns to approach mentioned above.
Sounds good to me, one thing to mention is that technically the ipq
platform doesn't *need* qclib, so qclib should be a special case path
available for any SoC that Qualcomm releases it for and that doesn't
have proper u-boot dram init support. It looks like the kodiak
QCLib.elf is 500kB and includes stuff other than DDR training,
but it could probably technically be used (even though the non-ddr
part would make more sense to do in u-boot code).

In any case no platform should be locked into assuming it will always
use qclib, someone might RE it and implement a proper ddr init driver.

Speaking of qclib, the license Qualcomm uses seems kinda insane to me,
they reserve the right to terminate it at any time, and the whole license
becomes invalid if any of it's provisions is invalid or unenforceable,
which I'm pretty sure is the case. They also say you have to delete
all copies of the files if they choose to terminate it, which if enforced
against coreboot would require them to rewrite the git history.
Could someone please force them to write a license that doesn't boil
down to "this is what our legal team wrote and you can't take it at
face value"?
> -Sumit
