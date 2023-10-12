Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F7DCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 07:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26D3186D1F;
	Thu, 12 Oct 2023 09:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cVCk0TA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E90CB86D3D; Thu, 12 Oct 2023 09:16:27 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8708986CE8
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 09:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697094977; x=1697699777; i=xypron.glpk@gmx.de;
 bh=maNUxfbl9be6OtZUroN3aQ4Rpt6C+GT5x1tpCWTFC3U=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=cVCk0TA9k9lI7pZR8QIURuDlqpeNhTB7mI5E0Gao+XrzAKu0c3a0G4Ift5uwim+RiHyYBLKpRzC
 t0GxmH2lwmOQ/ef2sLhVzPh+iRSWEVy8JY9UrpNV/dxyJQKIm/PvMaGtZenF2PMNj72P3syjIGeM5
 XT3wypC1+w0gCyvcmZqwazhLt+ZE5p6LsLujYcIt8m8vYn59WgkfE/qtrq+tcXL0/3o2Mym4wRVKW
 HSW63nzLfyuWF0LzE6oA6qJztmOUzdpEZl9HkLAow4rFwtKS7MBHmB52lpLDW0HiMQlKmLuFe3YuX
 syR6aGoNKPtfZXV2hCACluI3Hy4Y/GLN4WCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYbu-1rHfhv1yNq-00m3bE; Thu, 12
 Oct 2023 09:16:17 +0200
Message-ID: <83ab1f81-031b-4241-8734-46e9288fc261@gmx.de>
Date: Thu, 12 Oct 2023 09:16:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/26] net: bootp: Fall back to BOOTP from DHCP when unit
 testing
Content-Language: en-US, de-DE
To: Sean Anderson <seanga2@gmail.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-16-seanga2@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231012015626.3487451-16-seanga2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NsRNp8OydtTmC3YESSdi5vP5z3duZbOAMCse/xOYRe8ltRVqN8k
 gxVLcK2+xemxSYLRugIjMlmjxu0Um5kuJECQ3HqfZp1663NzIrrUGylS84dgoAi6InR43OI
 3lr96qn9eNaDK8jC0MP+KfZhdLHTd1mwZba965B16WM2G7RpHUaiLlSNMQpDx61orrYnM1V
 cQnPJz6T2J/hNBW02BXXw==
UI-OutboundReport: notjunk:1;M01:P0:Gx/VEQeTubQ=;Rwz63WvGIlq9QhCer5vWKTPH/1+
 MSgpUD3nvpbdHu1qDbjG1n4ySOF2WtivOcdBaxpiBdtP7yq6nyQOdeWT8nRmt1aw2K1hLOYKv
 eCSOV3PppkFnKiiC2yeb7Rq3HHg08OzyOvOP0ZZMden4LRek/uS/iSK2emWmI1LrtJ35hjliC
 R0nuCrn80nMb6PLgzW7XRReP8QUP0S6Fn1jbRGhrM8d68k/ne5DG4owuTCz1ouuXA6G7M2B0v
 yBkEIiv4O1n/xUu0D8WNZ7f8ZbImdRNK+XVSbNnuL12jeJFesqlOyASwIM/d1t+UwtgwAcaEk
 RWboEUiy2PQpjg2AfwG+mHlkoe+vBCpZOHrMWpa5EGzPEevrlsDi0sknh8FvD30fjNbYAvHyO
 R9FcwJYZI/w8AY8MTByNZH4bq2jUhohTJUrlxDGpIpAj7aVFqX6SpIWEbK+tmL7+mOBdp2ZyP
 nkzklnvh48ziA8kuNDppRLVgbzANi0T9/P7o2yCJSbqL1SfNarSv8tGtSMGbrC9YQxWojY6Pd
 s9KecAjP463Gs0xkHgD5EDj6mAV10lIaRK3js1K5VBcF1ZjgDUxJyyxdTdqzfvKj/WQqrvQmX
 yIX44ddNqPjzyY36EbeAPrZDkTi3lwT8c3VuuRFVtyGBJCZHRjTIlJSyDZwoi6yXyeo071F/n
 VdSvmI9z5Ll0vtI00LRk5N5wEXnxYbxB23Ez7NKXAnw/K+m79pXpYO0RHOJT4NSFEmr/AZ0A9
 sytSCV7CDldPn7cnfwJBduVpi6o1Z7TZWlpEg10JcfHWXV1Ej+y15zIQcwRqh7S0Loac0zKLx
 KaylFUUjOEw8jHDGttX2vG+RCmcBW9A0bYnOHmvaAobowhHatez8FByZ4nG/loWSQzRyb67gJ
 WchJ0BkmDrc0S1xHJ6n6Cf1DRzXxzoxzTOO4hzK90n6FjsKuSwjl73EoYxIMwFow9xlcWJOQP
 4UD3M15qgZn+xpr2f0WTmW+JlkM=
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

On 10/12/23 03:56, Sean Anderson wrote:
> If we sent a DHCP packet and get a BOOTP response from the server, we
> shouldn't try to send a DHCPREQUEST packet, since it won't be DHCPACKed.
> Transition straight to BIND. This is only enabled for UNIT_TEST to avoid
> bloat, since I suspect the number of BOOTP servers in the wild is
> vanishingly small.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>   net/bootp.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/net/bootp.c b/net/bootp.c
> index 2053cce88c6..7b0f45e18a9 100644
> --- a/net/bootp.c
> +++ b/net/bootp.c
> @@ -1073,6 +1073,11 @@ static void dhcp_handler(uchar *pkt, unsigned des=
t, struct in_addr sip,
>   			    CONFIG_SYS_BOOTFILE_PREFIX,
>   			    strlen(CONFIG_SYS_BOOTFILE_PREFIX)) =3D=3D 0) {
>   #endif	/* CONFIG_SYS_BOOTFILE_PREFIX */
> +			if (CONFIG_IS_ENABLED(UNIT_TEST) &&
> +			    dhcp_message_type((u8 *)bp->bp_vend) =3D=3D -1) {
> +				debug("got BOOTP response; transitioning to BOUND\n");
> +				goto dhcp_got_bootp;

This may result in unexpected behavior when running tests against an
actual network. Please, avoid this.

Best regards

Heinrich

> +			}
>   			dhcp_packet_process_options(bp);
>   			if (CONFIG_IS_ENABLED(EFI_LOADER) &&
>   			    IS_ENABLED(CONFIG_NETDEVICES))
> @@ -1099,6 +1104,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest=
, struct in_addr sip,
>   		debug("DHCP State: REQUESTING\n");
>
>   		if (dhcp_message_type((u8 *)bp->bp_vend) =3D=3D DHCP_ACK) {
> +dhcp_got_bootp:
>   			dhcp_packet_process_options(bp);
>   			/* Store net params from reply */
>   			store_net_params(bp);

