Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9A4C3DA4A
	for <u-boot@archiver.kernel.org>; Sun,  4 Aug 2024 01:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AF1C888CC;
	Sun,  4 Aug 2024 03:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722734906;
	bh=wiJv+nqTvL7OfBO8MxQIgDlDxLuh0DU+UG1KDKHPMZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CudXrEWBLZjCajvf08J1+64Vd3v35gtl7qaIKDuAg2bQcMvGW6Jm8DUmWepazGjMm
	 DXCeqTlCHzY4Qi8/5eDbNSZGD3u8SEVwR1niTr+ppJymCCi0PLEj9uvWwW7/OXWTzH
	 DG+bJ3MKZTxhWdNUPokNwFYB66MGUEWlOeO/QfJHWx9hOwMzfM54HNoiNgkKlw/jV1
	 wi3F3YTeXzKgV3n7eX9G+ZWfEsX2NK5sNsbkUTQwVN5mc84+6QnxFGvIIpt3+3uHI0
	 DDtXWB4LXjPFIetABiBN8/P1wEJfPBkyjf5Dbh0vmM7vSMHjSv06xHZ1cZ73GC65mg
	 Jh32TCFxiJsYw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2EC0688835;
 Sun,  4 Aug 2024 03:28:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722734904;
 bh=wiJv+nqTvL7OfBO8MxQIgDlDxLuh0DU+UG1KDKHPMZ4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=p4x/IjhLZRn7DpS36sA5vftLZBP2WvuaIVRmxkjgNlHd3mlqzlnMaU7vmQpNz5SzQ
 ie2ef9AV6qHnTDh0F4VOB6Er/jlnVSfMbZcKZIp+e3WVAxIXeFHAm4c9yBtXyFv14e
 xSBTtoAZZtU8t7FD/uYe7mh3BCWthVndF6ucM1yPDBqVNkRhUSrP35ZmUqpLJDuOky
 2/BH34ptNYGWhT7LyS9H4zjAxEpnZxZVvndQZshh/zO1XWKQczA3MSbo8eEZr6kFuM
 /giuWX7MYrR1e9X585KAPXtLWUqJmUHblmwDGJhAneuZIj/DLEmdjN1w5onF7I15ex
 38Lf4XaY6/3Cw==
Message-ID: <71758020-e482-4aaa-b7d6-d4e28a127571@denx.de>
Date: Sun, 4 Aug 2024 02:21:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] board: novena: convert to DM_I2C
To: Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, Tom Rini <trini@konsulko.com>
References: <20240803161513.486062-1-agust@denx.de>
 <20240803161513.486062-7-agust@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240803161513.486062-7-agust@denx.de>
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

On 8/3/24 6:15 PM, Anatolij Gustschin wrote:
> Conversion to DM_I2C is mandatory, enable DM_I2C
> to disable board removal warning. Convert EEPROM
> and IT6251 access to use DM_I2C API.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: Tom Rini <trini@konsulko.com>

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
