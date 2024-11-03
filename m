Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51F5E6781B
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 09:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E178909F;
	Sun,  3 Nov 2024 10:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cg73AnI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6120889102; Sun,  3 Nov 2024 10:38:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77DCA8907E
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 10:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730626710; x=1731231510; i=xypron.glpk@gmx.de;
 bh=FgC29GHOKTo76skAB2zs3g7SXz/+SOQlqtO/Rycj8bI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cg73AnI3bXksnki17j9Kr6fCSIXJG5JVDPHskVif32ZQY28L8I9MtATbkM3aHu/y
 ahUmjg0P/viASkGnMw0GGcEsIaMu5U036zm/X/d7YsgiYhJ7dm9DbOZdOdAST2cl+
 GEyTaUOLleqLbMB4Lc3r3x3oIP8LaaPUugNzi4BWm6HsVysjfbTBppSLzTw+z+oFr
 IhZarNCmWOqgfTM3OhULnT6eXH+B7+VpsST/36NseW57fI2S+Ahu/01W68/e8NrwL
 F/39asEdgGKzeMDZlWxMvRioOF82jiBtfejC5IJCwNHuusGpnz8m8brYNewkOcAcD
 LYql5IUuEvvgNVg9/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD6g-1tkjh62nFy-00j21T; Sun, 03
 Nov 2024 10:38:30 +0100
Message-ID: <e1332498-0dad-46f8-8cfa-1572b0da0522@gmx.de>
Date: Sun, 3 Nov 2024 10:38:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/20] test: Move unicode_ut test into lib
To: Simon Glass <sjg@chromium.org>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241102193715.432529-1-sjg@chromium.org>
 <20241102193715.432529-15-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241102193715.432529-15-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vuIaX++bF6xLBRuyz+KwDZu19EM8mcERk/cqM/DyfT1rrHmocBR
 g+ihGyxtv31aJu4UyHT3n8WyDkbSaA6eqYbJ0LvbihlMd0nHYrJpmb9IenywQKI1E/PXebI
 tRWZuxAmlN29vTF4rT9iSjVJDTTedlawJnWaWoMzSdoxIEK3mk6reM2kALbuRtc3xc00Q5a
 30PrGOPFmTa0XfN/7wpmA==
UI-OutboundReport: notjunk:1;M01:P0:yppGAq8AZe0=;byQndg/fubkvcSJsH8azb/L4wmy
 7aRN0xaDM8CsZp+mPi/wZiheDtBTg1V08Z00wApV72oaS4e+wKEwCK9NlHhYFtIotEoBETnKW
 OwaEP6oR7gdt6Zn/rW84ijCFxsNCzb9n/wY/OZslVpASIRlU8KrMrCxwWbvZuZKkq522CWai5
 tNlZ4r6iyfapLj+Q3DB/7I6yj0ODDy/MFU6GMzzA4JFb25p/73P358oLUaQGDDx8Ti6HfIw5s
 bcgrk8ce/J4srvwQnCQVOXI2Z+cM7C5in3BVWsmnIztL4s30D8u6f20n4JxJFnRPmLFqE8Jk2
 vTt/6RTWlv5xXtzGmoPUTe+XjZx3gawNcfi7WHSa9dryHSX4R1G7LvnaNGw8+ouDSWK88SBZC
 sQXMNydJKFKrCtBHAlbz04Ou6nITPt1KgVev5YP+/JdfadwoVne/7kW0XXUbkLvuSDF+H3Yg6
 riN1v4mWwL9Bbg1tvpYk80JY0ErsJGzYsaftGvRTCRM0t7sg1PQbaGYyUJHy6mvZnzcTopgyL
 we3OIQZLn5jlkDHeF7FnILOxr6ZKl+BZL9ZOfPL5xRr+TrKZw/rBb3fjFhl7P8nKbis22XtRI
 0lo7op1jrKKritrggOtCJg78lZH68h0HjqcEfaQYKny47x5vD2WsEfQb8aWa0NyM0n3Q3qyQe
 tfq5L4KeP1YlwTGdAhnHguXGHtuyN7X/gq4QE9xzFDuBwmYRwvHcuLdD9px1SBzLbZVH11NjE
 VJU++3zt4c/rNNujZvPEaHGnQ6otQ2FfVs6Tiy8idwWeQ0JRzw6VcgaSwFaVMWO/16Ivz+e/F
 5r5af/eAYmjf8bpDi0OEX9Bw==
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

On 11/2/24 20:36, Simon Glass wrote:
> This test doesn't belong at the top level. Move it into the lib/
> directory, to match its implementation. Rename it to drop the
> unnecessary _ut suffix.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
