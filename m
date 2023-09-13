Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3687CA550A
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 08:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68A4086D31;
	Wed, 13 Sep 2023 10:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=goldsimon@gmx.de header.b="HZIzbMPN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF68886E93; Wed, 13 Sep 2023 10:38:34 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2422486AEE
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 10:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=goldsimon@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694594307; x=1695199107; i=goldsimon@gmx.de;
 bh=hH9WNXWbGBZuR795Fr6knBVsO4t2THYzbBMJxuvCR44=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=HZIzbMPNE+tAKT5kgVBLjrvMA0AH+We1nMH6tH4bCzgaHOxx7P6ocW6QKL1yPQbccQcCASetHGd
 sinM3sE61arff8raeEqZ2QBQIF65HPgFWREwfp5Y8DE07jO2dV9INvwLLTJXRSUFdjyFbIhCgxuuf
 RJexhjjsjZG1CGy3vibVSDuKu1p8+PrCRFMO1Oxj4JfkwHsS0AlGjmhMaoWSn4ArWQhwB2l+OEd4B
 G6cBxVzxY5sxFuFY7mD4I3q5CglU7JvqFFa4R+Hb8XYGbuSTspDgKLcNOwzzbWNMulCs++jLWfddQ
 XYGNlqa4NlnonW6xPvFytKy4aze44HHAdfTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.88] ([176.199.209.230]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mplc7-1rVr702YcH-00qBu6; Wed, 13
 Sep 2023 10:38:27 +0200
Message-ID: <e5931bb5-2dfd-d5f9-69b2-38d14eebf181@gmx.de>
Date: Wed, 13 Sep 2023 10:38:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCHv8 05/15] net/lwip: implement tftp cmd
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135320.7066-6-maxim.uvarov@linaro.org> <ZQFTbcuLihQm2qoI@hera>
From: Simon Goldschmidt <goldsimon@gmx.de>
In-Reply-To: <ZQFTbcuLihQm2qoI@hera>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eiJA4x/BLEkdpFln4H63S6RLMuzS1yRH9tViqpzcZzKs8ntNwmM
 oYsp9X8z70+gbpbxrD/hYoAfiaAOqIhO0EurVZUT3pIgs29NmSnYJATgHkcFVinynAsJuEU
 sOUNdbgqDZUjKEcHacGOf2+bzelIxbPw6vGPzHdNShGQD2c5ighh7/jR6dBmfD6YL+HB49i
 KSU/Ny6M2DdLBKo83UlLw==
UI-OutboundReport: notjunk:1;M01:P0:A5uCWaxWYZs=;kjedIMMCe1xyrwaGa996brCynGX
 i/JAmp8ixB93dp7/YKWGJk1Z7w1h3yjgMh0fO5te5HHvQFbfuWLbEqZP3kMZO+sRHLXEM3OpZ
 E/Atb/tY8spi3Kx4IQsn9Z2DbGe4e30a6fSs0E9ltXMIK+6266l7FBXnc1wBRaO8SOHt0BMxA
 j/Z0u4MkP2rssVAS21B2BhlBhAVS3XaRolV44Seb8rQsVMFJy+TyLWE9v3L2ifEredHsKyoK3
 QVCFDtC6yogZJQyxQZ+r2qmP/fvohvw5kxt6bIKZU+LZ6Zni014mP90MiATxcGVxSse4zZtDX
 u8q5njr4BvX5TwI4o+lm/FeeT37jppzLDjq2ZrjKT3uR0cBSt5gm1Cw/sd3+DkMhdb7GyjVAx
 ntwXDq9/IWOJr/abSM8gtSJOWo0xnq0osZW3+nvd58Gqlmkg8cS+EupCtZmh2DoJaaWpbiUph
 anMC1hd1WmBDiYl3sQBCTfDoh8mvkvYNzIJNYZJy/HN54JOX6ITJXiyVEbIgKa2lfjSPSGXOJ
 EPvJSFgrWZzUhNttiXaO3XcOIAIltR+IoceNctFe2E2+7sMqE8u8UKnxLROTkd11ZxG/XbDY4
 t1hNVYxIf9sLXbWKS0iVFn7hIFUQtl0te566owTKYK/6KeASdk6b9tYKV0nzCzQoIpjOxXZF6
 C6z7Z1uT2kqZSusGxfkDUdUfXX76mR2hnKCmopvsyNvEblz8AEzqkGuP9YTDA9DmV4CQCmfKL
 GTig20nKACcikz6j7FFwwqbDpm6RIFVgE1e+VuCkeEMks096Z/sG5SrtR0rdLPhNAnAGRPsQd
 Nn3DNzeYDKNn3tKkGutjJ5kwkLXWTTT0E2U8NIM5fjePwuIZVtwRonp57r+bQB6tJNCUX+ZhK
 Xqae34WdzBlGNMH3UekGBR1udIqTekbNvV+PQmbrQOWvyB4Hns8puPxdngRrJ1cizA39NC0p+
 wV6dKCBYH81NfGImPE3EF+ein/k=
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



On 13.09.2023 08:15, Ilias Apalodimas wrote:
>> +
>> +/*
>> + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
>> + */
>> +
>> +#include <common.h>
>> +#include <command.h>
>> +#include <console.h>
>> +#include <bootstage.h>
>> +
>> +#include "tftp_client.h"
>> +#include "tftp_server.h"
>> +#include <tftp_example.h>
>> +
>> +#include <string.h>
>> +
>> +#include <net/ulwip.h>
>> +
>> +static ulong daddr;
>> +static ulong size;
>> +
>> +static void *tftp_open(const char *fname, const char *mode, u8_t is_wr=
ite)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static void tftp_close(void *handle)
>> +{
>> +	log_info("\ndone\n");
>> +	log_info("Bytes transferred =3D %ld (0x%lx hex)\n", size, size);
>> +
>> +	bootstage_mark_name(BOOTSTAGE_KERNELREAD_STOP, "tftp_done");
>> +	if (env_set_hex("filesize", size)) {
>> +		log_err("filesize not updated\n");
>> +		ulwip_exit(-1);
>> +		return;
>> +	}
>> +	ulwip_exit(0);
>> +}
>> +
>> +static int tftp_read(void *handle, void *buf, int bytes)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int tftp_write(void *handle, struct pbuf *p)
>> +{
>> +	struct pbuf *q;
>> +
>> +	for (q =3D p; q !=3D NULL; q =3D q->next) {
>> +		memcpy((void *)daddr, q->payload, q->len);
>> +		daddr +=3D q->len;
>> +		size +=3D q->len;
>> +		log_info("#");
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void tftp_error(void *handle, int err, const char *msg, int siz=
e)
>> +{
>> +	char message[100];
>> +
>> +	memset(message, 0, sizeof(message));
>> +	memcpy(message, msg, LWIP_MIN(sizeof(message) - 1, (size_t)size));
>> +
>> +	log_info("TFTP error: %d (%s)", err, message);
>> +}
>> +
>> +static const struct tftp_context tftp =3D {
>> +	tftp_open,
>> +	tftp_close,
>> +	tftp_read,
>> +	tftp_write,
>> +	tftp_error
>> +};
>> +
>> +int ulwip_tftp(ulong addr, char *fname)
>> +{
>> +	void *f =3D (void *)0x1; /* unused fake file handle*/
>
> I haven't dug into lwip details yet, but I am not sure this is safe to u=
se.
> Simon, since you maintain the lwip part can you elaborate a bit more?

 From the lwIP design, using an invalid pointer here is ok: that pointer
is only used as a client handle which is never dereferenced internally.
The only requirement is that it is not NULL, as that is the validity
check for the tftp client to know the handle is valid (or e.g. open
failed etc.).

So while we can leave 0x1 here, using a static uint8_t would probably be
better, at the expense of using a byte for nothing.

Regards,
Simon

>
>> +	err_t err;
>> +	ip_addr_t srv;
>> +	int ret;
>> +	char *server_ip;
>> +
>> +	if (!fname || addr =3D=3D 0)
>> +		return CMD_RET_FAILURE;
>> +
>> +	size =3D 0;
>> +	daddr =3D addr;
>> +	server_ip =3D env_get("serverip");
>> +	if (!server_ip) {
>> +		log_err("error: serverip variable has to be set\n");
>> +		return CMD_RET_FAILURE;
>> +	}
>> +
>> +	ret =3D ipaddr_aton(server_ip, &srv);
>> +	if (!ret) {
>> +		log_err("error: ipaddr_aton\n");
>> +		return CMD_RET_FAILURE;
>> +	}
>> +
>> +	log_info("TFTP from server %s; our IP address is %s\n",
>> +		 server_ip, env_get("ipaddr"));
>> +	log_info("Filename '%s'.\n", fname);
>> +	log_info("Load address: 0x%lx\n", daddr);
>> +	log_info("Loading:");
>> +
>> +	bootstage_mark_name(BOOTSTAGE_KERNELREAD_START, "tftp_start");
>> +
>> +	err =3D tftp_init_client(&tftp);
>> +	if (!(err =3D=3D ERR_OK || err =3D=3D ERR_USE))
>> +		log_err("tftp_init_client err: %d\n", err);
>> +
>> +	err =3D tftp_get(f, &srv, TFTP_PORT, fname, TFTP_MODE_OCTET);
>> +	/* might return different errors, like routing problems */
>> +	if (err !=3D ERR_OK) {
>> +		log_err("tftp_get err=3D%d\n", err);
>> +		return CMD_RET_FAILURE;
>> +	}
>> +
>> +	if (env_set_hex("fileaddr", addr)) {
>> +		log_err("fileaddr not updated\n");
>> +		return CMD_RET_FAILURE;
>> +	}
>> +
>> +	return CMD_RET_SUCCESS;
>> +}
>> --
>> 2.30.2
>>
>
> Thanks
> /Ilias
