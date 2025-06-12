Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A666EC61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 15:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 093ED82B70;
	Thu, 12 Jun 2025 17:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yFIL00+H";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sV1ovdtc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C71E282B97; Thu, 12 Jun 2025 17:25:27 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78ADE828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 17:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bJ5v91VHNz9t0p;
 Thu, 12 Jun 2025 17:25:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749741925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=alvYvAmUXAwSHSLkhxnxfXoqEwZo1sS0LKiTc0nPB8o=;
 b=yFIL00+H17eeHd+lnA3UcFwQODTzpcFMvjMPy22QkoxY7vlCs1t7l+avKQ+7XdXrOhjtLX
 EgFzwbroE3av8WtXyZKaoVdJc5vglNNALUKZ6yJ4R4mSV30Z9F8n0HP01TGQMIxpmtElX/
 x9ooD2Xc4jTwSnVA/sK6a7DZnWyT8ni4BBn2Y03UMBLOiU7CoekMuyhLWDXxjizLCKArU4
 BfBckFElU5FudaKei2EkWRSjheuhcgMl0fyO7D7kq3/NUADo8VwZsGp4eeN5ttDXM0nPSQ
 s5QMz6WVEypkunmZKGBdNzzG5ZPNNgdlQGkvas21aJI43Wry3RMUYVyNfWq3Yg==
Message-ID: <7da8d968-e329-43b4-90ad-cc1249a0d3cc@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749741923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=alvYvAmUXAwSHSLkhxnxfXoqEwZo1sS0LKiTc0nPB8o=;
 b=sV1ovdtcSwRZsyDdNtrI5kWa6ZaWz3u9Z4Hsag1LtoGFl46JoAh/jMpUa0dKg/7DWUm58X
 RG1c/k9hrPpEfhvxidP0P8qMgk3zp3ECIMYBt/UTtl/cXs3YjD8asEhDxaB5klQg8ASz+C
 Kt2fGOOSjDK4H9J4fWxOvj4eBNCdAsrNUEZspt5SXQoxt4MUbXq1FCtZcnX4N6ItWvQsI8
 Sriv92OR7GpVeh8t0perzPYgHBFjSZ7iHneOPyoCGiRqcIlu5gm60uyaLlI5VoSB2cepQj
 tX/fw4e6UE/V3YGSMXeAechdV8IAexq98pWKP5xMnkMhZ1kT2lYPy8AGUJoblA==
Date: Thu, 12 Jun 2025 17:25:19 +0200
MIME-Version: 1.0
Subject: Re: Aw: [U-Boot, v1, 1/1] net: phy: Add the Airoha EN8811H PHY driver
To: "Lucien.Jheng" <lucienzx159@gmail.com>, frank-w@public-files.de,
 Tom Rini <trini@konsulko.com>
Cc: ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 marek.vasut+renesas@mailbox.org, paul.barker.ct@bp.renesas.com,
 pbrobinson@gmail.com, u-boot@lists.denx.de, joseph.lin@airoha.com,
 wenshin.chung@airoha.com, lucien.jheng@airoha.com, daniel@makrotopia.org,
 ericwouds@gmail.com, albert-al.lee@airoha.com
References: <20250511051400.29853-1-lucienzx159@gmail.com>
 <trinity-e740c5ff-b6cd-404c-82c4-eaf0642a13a6-1749722988086@trinity-msg-rest-gmx-gmx-live-b647dc579-66mhx>
 <20250612143641.GL1382132@bill-the-cat>
 <21560DBA-8398-47D3-95EA-719508A689A8@public-files.de>
 <3a9d3cf6-99cd-48fe-ac38-08474de79b8c@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <3a9d3cf6-99cd-48fe-ac38-08474de79b8c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: dswqo1rsiwobmyjw6ym78wiamgdcq1ni
X-MBO-RS-ID: bd22523c7f3c2796f67
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

On 6/12/25 5:04 PM, Lucien.Jheng wrote:
> 
> Frank Wunderlich 於 2025/6/12 下午 10:44 寫道:
>> Am 12. Juni 2025 16:36:41 MESZ schrieb Tom Rini<trini@konsulko.com>:
>>> On Thu, Jun 12, 2025 at 10:09:48AM +0000,frank-w@public-files.de wrote:
>>>
>>>>> Gesendet: Sonntag, 11. Mai 2025 um 07:14
>>>>> Von: "Lucien.Jheng"<lucienzx159@gmail.com>
>>>>> Betreff: [U-Boot, v1, 1/1] net: phy: Add the Airoha EN8811H PHY driver
>>>>>
>>>>> Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The PHY 
>>>>> supports
>>>>> 100/1000/2500 Mbps with auto negotiation only.
>>>>>
>>>>> The driver uses two firmware files, for which updated versions are 
>>>>> added to
>>>>> linux-firmware already.
>>>>>
>>>>> Locating the AIROHA FW within the filesystem at the designated 
>>>>> partition
>>>>> and path will trigger its automatic loading and writing to the PHY 
>>>>> via MDIO.
>>>>> If need board specific loading override,
>>>>> please override the en8811h_read_fw function on board or 
>>>>> architecture level.
>>>>>
>>>>> Linux upstream AIROHA EN8811H driver commit:
>>>>> 71e79430117d56c409c5ea485a263bc0d8083390
>>>>>
>>>>> Based on the Linux upstream AIROHA EN8811H driver code(air_en8811h.c),
>>>>> I have modified the relevant process to align with the U-Boot boot 
>>>>> sequence.
>>>>> and have validated this on Banana Pi BPI-R3 Mini.
>>>>>
>>>>> Signed-off-by: Lucien.Jheng<lucienzx159@gmail.com>
>>>>> ---
>>>>>   drivers/net/phy/Kconfig       |  43 ++
>>>>>   drivers/net/phy/air_en8811h.c | 852 +++++++++++++++++++++++++++++ 
>>>>> +++++
>>>>>   2 files changed, 895 insertions(+)
>>>>>   create mode 100644 drivers/net/phy/air_en8811h.c
>>>> Hi,
>>>>
>>>> is there any progress? i see no review or apply (+tom in To-header).
>>> I'm not super thrilled at the concept of having to load firmware from a
>>> filesystem. But since we have to do this anyways in other cases, is this
>>> something we could be using FS_LOADER for or no?
>>>
>> The filesystem loading was requested in mailinglist.
>> Original version loaded firmware from emmc boot1 partition (current 
>> openwrt driver version) or c header file generated from the binaries 
>> (my version). I do not know FS_LOADER yet,but if this a more generic 
>> way to load firmware file it could be a way. Lucien,what do you think?
>>
>>
>> regards Frank
> 
> I'm not very familiar with the FS_LOADER part of U-Boot, so I'll need to 
> look into that.
I also have to look at firmware loading at some point soon, but first I 
need to sort out my todo, I am entirely overloaded recently. About the 
FS_LOADER , I feel it never really took off, but maybe it improved since 
I looked at it last ? We clearly do need some generic firmware loader, 
one which also covers SPL firmware loading, I am just not sure how the 
interface should look like just yet.
