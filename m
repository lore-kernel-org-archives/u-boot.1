Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0271C3DA79
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 01:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2161876F6;
	Tue, 16 Jan 2024 02:01:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705366866;
	bh=pZX5nLaMv6cDJI7utqbMirb3TL+OYSJ/R2XaKBtBcms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HG9uyi00hB7q5V2Jixr2JoWrW73W19O5RV7yaJpl3z/q9ItFZ34woyl0SbOjbxMsM
	 mJWYsuZZ1aY6LOF351nj0NdeM35xBKvvl1RdOtVdEk2sPWa3mAX5qrvy9V8vFRIs9t
	 2mafzg+FfTgJFJGCzX4juf1DvC8LE+o3D2hXBDEznpbSGH6uWqxEvC/nOz0YtmDS31
	 jk2AFdnbl6urhsyQ870AZEeXBNLaJQ2cS9HRqZ4KXRwNI4CyPSetykEHqJrPPiEIme
	 Q6w1EX2HrWChCNvYw9l2r1QsrS4jsGWqxgX7NFgqouOUS6iBcQlkPFGgyKY2EZ+ZWO
	 g0bD3G/mJIG1Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 723CC86308;
 Tue, 16 Jan 2024 02:01:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705366864;
 bh=pZX5nLaMv6cDJI7utqbMirb3TL+OYSJ/R2XaKBtBcms=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ue4Hq5osQnzxu6aEL81E4YaSHLreZC9f9kq5FsWscdpPnqx/RzFJJXvWpfqk9GLtH
 jHL0fw4HDj19nfAr79Jf7LC1v7mh3ewTvVRSU9VNNkhZevvNBIDM/Nt1fhmcrXrmuZ
 LFK18emGq80dx+HTmZGn77HSXVbgBO1fEPdVV4WdxeDEYBKrNlZrrXMy14IUQG02Xu
 Zbo/xj1fPlOg0C/5g3wjKvR6j0ZFNrd7prwurcEDxdoeW0uyJY+EH33cbCzP6m4b/j
 3VeMJOFWXYR8/n1OmOT0Y2vm9blHQOdz8++ImO5k1V47iupdg89hcConVd6dfLGv+n
 lp8OPMy6vD5fQ==
Message-ID: <0da23033-3084-4cf0-9339-10cfa0ba5351@denx.de>
Date: Tue, 16 Jan 2024 02:01:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] ARM: imx: verdin-imx8mm: Set CAN oscillator
 frequency based on model
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Stefano Babic <sbabic@denx.de>
References: <20240113183350.176131-1-marex@denx.de>
 <20240115154420.GA31739@francesco-nb>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240115154420.GA31739@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 1/15/24 16:44, Francesco Dolcini wrote:
> On Sat, Jan 13, 2024 at 07:33:17PM +0100, Marek Vasut wrote:
>> The older i.MX8M Mini Verdin SoMs before rev. 1.1C came with 20 MHz SPI CAN
>> controller oscillator, the newer SoMs use 40 MHz oscillator. Handle both by
>> overriding the oscillator frequency just before booting the kernel.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
>> Cc: Fabio Estevam <festevam@gmail.com>
>> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
>> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>> Cc: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Philippe is no longer in toradex, removed from cc list.
> 
>> Cc: Stefano Babic <sbabic@denx.de>
>> ---
>>   board/toradex/verdin-imx8mm/verdin-imx8mm.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
>> index b2781b51d6a..8bc1a51eeb1 100644
>> --- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
>> +++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
>> @@ -142,6 +142,25 @@ int board_phys_sdram_size(phys_size_t *size)
>>   #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
>>   int ft_board_setup(void *blob, struct bd_info *bd)
>>   {
>> +	const char *canoscpath = "/oscillator";
>> +	int canoscoff, freq, ret;
>> +
>> +	canoscoff = fdt_path_offset(blob, canoscpath);
>> +	if (canoscoff < 0)	/* No CAN oscillator found. */
>> +		goto exit;
>> +
>> +	if (tdx_hw_tag.ver_assembly < 2)        /* rev. A or B */
>> +		freq = 20000000;
>> +	else					/* rev. C or newer */
>> +		freq = 40000000;
> 
> So, the situation is more complex than what I thought initially.
> 
> The actual frequency of the oscillator depends on the whole
> `struct toradex_hw`, you would need to check prodid, ver_major,
> ver_minor and ver_assembly.
> 	
> In addition to that code should not expect `ver_assembly` to be an
> increasing number, this is just a number that is matching the BOM.
> 
> The actual `prodid` (PID4 in Toradex naming) that have the CAN
> functionality are 0055 and 0059.
> 
> 0059, V1.1A and V1.1B, use a 20MHz oscillator
> 0055, V1.1A, V1.1B, V1.1C and V1.1D, use a 20Mhz oscillator

Do you happen to have a table of what was populated with which 
oscillator, so I can fill all the 20 MHz parts in right away ?
