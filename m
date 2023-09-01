Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACA6CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 09:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CD8486901;
	Fri,  1 Sep 2023 11:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693561953;
	bh=NsClyzo/rELo1wEjX70SoHpbaYAYwa0o4di9+vTkmD0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NSxKCmA4FBz3aBu3urfvzMBm5uWIBfrVuF+JTZZ4M++XpG7tjd45ncwnjsCM9Usk2
	 yBvEv8NqizSki6T20QB2dp6cHR8sTRCqrdtRNTolwEdcJC4RZSZnUGZ4mp6txQVjAg
	 p29nUYwMUDce4v8OndYkFPQyM4Q/PzQN7FtvhKTDPZLTIPkNO8T1xiSBPYjxeQ0Ddv
	 9xnQHTH+0pdzKL1oFgrqbaxY9+ofCqB8wll8OnnFP0oBdcR8wn6YRZE9xLfKgS7fK9
	 LgoyeCcOomLzhURze2fp07nHaamIA8wFWn0oYkaIcLODet07oOowDWky7mK2Kzhhiu
	 7KucUyUxb5ypw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 954598688B;
 Fri,  1 Sep 2023 11:52:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693561952;
 bh=NsClyzo/rELo1wEjX70SoHpbaYAYwa0o4di9+vTkmD0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=X9q+NGZeFhv0rILOQKVe++viWq1PmJI1vQGpzHnluB9wuXgb9ipRJ6sKkSVw3burS
 PTL20gszZ+icADhzM60PcPdIlGUaLn4Ywv6GE2xoj1B07Ls9Ilj+sD3tJrusCzV7Rj
 xJb5OyLJVnkYpKvKSXfO093dm1RXhlR+zYNprKg1RI8ue4CVnsuCw4uNmuVGVBT34Q
 zT0vVUW0Cpe64+19lpWD80/z7NgHzD8TcE7u0gJ1tbt02ZYcl9A1kOiqZAKvZYmZJ5
 zGwgDp3fRK1uwmfvGSw1fo2xCFdbuS6k7VCR+mBH9Mopxuft3eZ/SzTQVuppFLnwyQ
 pdo8YJbK4Uujw==
Message-ID: <46485625-5146-eeb6-f6dd-050dc184c433@denx.de>
Date: Fri, 1 Sep 2023 11:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 11/17] spl: sdp: Detach the controller on error
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Cc: Angus Ainslie <angus@akkea.ca>, Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>, Kever Yang
 <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, kernel@puri.sm
References: <20230819142407.49632-1-marex@denx.de>
 <20230819142407.49632-11-marex@denx.de> <87zg2jqb6w.fsf@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <87zg2jqb6w.fsf@baylibre.com>
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

On 8/22/23 18:44, Mattijs Korpershoek wrote:
> On sam., août 19, 2023 at 16:24, Marek Vasut <marex@denx.de> wrote:
> 
>> In case anything errors out during the SDP transfer, detach
>> the controller instead of bailing out right away. This way,
>> the controller can be reattached on next attempt.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Angus Ainslie <angus@akkea.ca>
>> Cc: Dmitrii Merkurev <dimorinny@google.com>
>> Cc: Eddie Cai <eddie.cai.linux@gmail.com>
>> Cc: Kever Yang <kever.yang@rock-chips.com>
>> Cc: Lukasz Majewski <lukma@denx.de>
>> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Stefan Roese <sr@denx.de>
>> Cc: kernel@puri.sm
>> ---
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
> Nitpick/question below
> 
>>   common/spl/spl_sdp.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/spl/spl_sdp.c b/common/spl/spl_sdp.c
>> index cc4fb4f7cca..f6b99c1af5a 100644
>> --- a/common/spl/spl_sdp.c
>> +++ b/common/spl/spl_sdp.c
>> @@ -25,13 +25,13 @@ static int spl_sdp_load_image(struct spl_image_info *spl_image,
>>   	ret = g_dnl_register("usb_dnl_sdp");
>>   	if (ret) {
>>   		pr_err("SDP dnl register failed: %d\n", ret);
>> -		return ret;
>> +		goto err_detach;
>>   	}
>>   
>>   	ret = sdp_init(controller_index);
>>   	if (ret) {
>>   		pr_err("SDP init failed: %d\n", ret);
>> -		return -ENODEV;
>> +		goto err_detach;
> 
> Shouldn't we call g_dnl_unregister(); here since g_dnl_register() was
> sucessfully called before?

It should, fixed in V2, thanks for your help !
