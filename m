Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC17CA5508
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 08:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D76EC86D23;
	Wed, 13 Sep 2023 10:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=goldsimon@gmx.de header.b="JCiAx7ci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0934C86E1A; Wed, 13 Sep 2023 10:35:11 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73DA086D23
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 10:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=goldsimon@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694594104; x=1695198904; i=goldsimon@gmx.de;
 bh=dTtZoRs3zxE8sZgV96R/zXGnDx2EzUXg/2ER0nIor3g=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=JCiAx7ci0AfJ13eytBnZub7pdSCVm/pO8qtanTcOLCBoAJtk2nZi/tN8qZuu6FW1oSv0PJuAFkE
 HzZXjqg5CAzvSLcZc6gIN6zERidsGny/15xvKN7+o9vIKyxASUgJOA1pvrlqcNgWscNHMCZag0VL6
 1musLBa5/3eepTxzIt2X7LU0yX+k88wXPRh1nnsN9txbm6Rjr7qpqIzN9jgDbdcgXnaEQ97tBEFpk
 z6cnqVxiKs+5iRU/Ux1exSHS42XcoF/5WNhjTIGu96xK56dz7F8jbsFyv1iCZxdRfkjdtdb0uyuj5
 SgOPGf8k27txOlAAQfkQ/AJ7MfxtCiONHYSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.88] ([176.199.209.230]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYPi-1rMGnH3Zk0-00g1tE; Wed, 13
 Sep 2023 10:35:03 +0200
Message-ID: <82a1ab46-6a72-e0e6-447f-1845942faab6@gmx.de>
Date: Wed, 13 Sep 2023 10:35:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCHv8 04/15] net/lwip: implement dhcp cmd
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135320.7066-5-maxim.uvarov@linaro.org> <ZQFRqo+wPifYRCg/@hera>
From: Simon Goldschmidt <goldsimon@gmx.de>
In-Reply-To: <ZQFRqo+wPifYRCg/@hera>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4R/mYuqwJidjVguq0p8ooUG0zTsRh9kwYFCJdREs2kntfTsis5M
 p+60VZF6OtZ7n9rupV+yWKOKXWxdpqkd9VKRZx1L4XIErASXz9ORUxSgFH92s3N7aBEdJho
 LlYkcmHqhNMlUbxGMYnSGLPYOD6Zl+OCHQ+XttDNXU2bmflvCW63HSswP/AqL5544nqb+xj
 PUdZH5blsmPsYlDfvhx6g==
UI-OutboundReport: notjunk:1;M01:P0:kuSheeirHEk=;WFEXIoqX4y9HF8vOxFqJIf4SWrg
 d1f7gg3at4eXxLYuntJW63kqHx/HOUvfPMt47x9cDQYWDItDsP1zcDoSszdLNI/2V5Vooi9YW
 hcBfmVDeWPQTQvJB1EO0WSkTQzS6IPUfoIBTuK7wmuuheRFpitInVq5WaqMfa1nazKHrrPM0X
 01vM94SKhnPmzOWMuVnX6ePZLT+C5PtF/e19ejOGSB8PSI1UHUZM3Uhsxb4YnIHib5aEuddak
 CNWS158V9HgWeGKycg0Win2ba0WyCmJ4uUOaUvPl4czcNrESSPZ2AilLudRhUDm4liSvIStHp
 Xn/1PY2r8qVe339pLK70zjkvJ5TFgNR/2MzT08imTS3znAWSjcX2EFAy47R7lRRnHO7X82W4t
 M4OH5Eai38mnOK+w0lGx2kx8j87/Q0f4Z161rVVxruR71+LLD/gEHejCmOHOdG6TlWa9dfk0d
 wq9uNOmDf6e/5S67xkm4eiN8lmqZ1ZZPf4+l0xJWSlwVbR0NLBFny5mUm4mhpqoP2i6HrgccE
 szbIGrZwHsG3bJ82hst7yz9c/fM2tUTerlvajV5GE7yTfYFxeJY6NlRTRvSgDd1NoiVc2P+Dd
 3rIdszSn821M2xHYKwoqEvBbB6orCtq5vt/A4KTZs3W1ZUW+GfovHt4F9Gr5154XHVebtOpOg
 lr2KX/EKYF0bYiWyCva4oqSiM4CwkxXUKdctpAAlEMW3YiIjvCvh0/qx53aorQaZQzDvnP33W
 RnUsNPUTKHqVEscLK2kzXGYNM+FpLa4nA1claSqsaCKHDf9wfm/uEKzLj0PLy6oRUhKxPl6q3
 aH28FZS3r3vDSYpR6zlC/6vgLcMihwCFDMH4vXRYxcrvnF02ofWrIvq4iLn4ja6CCocKk7pVk
 B2OtnVC9ygSRjDFGBhZjKnTwlk9bdSbHnx6Zlo4dxA+SLCFPiOvyeiQU6Eu477L29j+R5+HCU
 mLs9lTdMW0NfhgOMefcyNitFtv8=
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



On 13.09.2023 08:07, Ilias Apalodimas wrote:
> On Fri, Sep 08, 2023 at 07:53:09PM +0600, Maxim Uvarov wrote:
>> +
>> +#include <common.h>
>> +#include <command.h>
>> +#include <console.h>
>> +
>> +#include <lwip/dhcp.h>
>> +#include <lwip/prot/dhcp.h>
>> +#include "lwip/timeouts.h"
>> +
>> +#include <net/eth.h>
>> +#include <net/ulwip.h>
>> +
>> +#define DHCP_WAIT_MS 2000
>
> Is this the time we wait for a dhcp reply? If so we should bump it to
> something higher
>
>> +
>> +static void dhcp_tmo(void *arg)
>> +{
>> +	struct netif *netif =3D (struct netif *)arg;
>> +	struct dhcp *dhcp;
>> +	int err =3D 0;
>> +
>> +	dhcp =3D netif_get_client_data(netif, LWIP_NETIF_CLIENT_DATA_INDEX_DH=
CP);
>> +	if (!dhcp)
>> +		return;
>> +
>> +	switch (dhcp->state) {
>> +	case DHCP_STATE_BOUND:
>> +		err +=3D env_set("bootfile", dhcp->boot_file_name);
>> +		err +=3D env_set("ipaddr", ip4addr_ntoa(&dhcp->offered_ip_addr));
>> +		err +=3D env_set("netmask", ip4addr_ntoa(&dhcp->offered_sn_mask));
>> +		err +=3D env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr));
>> +		if (err)
>> +			log_err("error update envs\n");
>> +		log_info("DHCP client bound to address %s\n", ip4addr_ntoa(&dhcp->of=
fered_ip_addr));
>> +		break;
>> +	default:
>> +		return;
>> +	}
>> +}
>> +
>> +int ulwip_dhcp(void)
>> +{
>> +	struct netif *netif;
>> +	int eth_idx;
>> +
>> +	eth_idx =3D eth_get_dev_index();
>> +	if (eth_idx < 0)
>> +		return -EPERM;
>> +
>> +	netif =3D netif_get_by_index(eth_idx + 1);
>
> Why is the +1 needed here?

Netif index is driven by posix design and is 1-based in contrast to
U-Boot's 0-based dev index. A comment noting that would probably help
the ones not knowing lwIP.

Regards,
Simon

>
>> +	if (!netif)
>> +		return -ENOENT;
>> +
>> +	sys_timeout(DHCP_WAIT_MS, dhcp_tmo, netif);
>> +
>> +	return dhcp_start(netif) ? 0 : -EPERM;
>> +}
>> --
>> 2.30.2
>>
