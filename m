Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDF3CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 17:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD3B686A23;
	Mon, 16 Oct 2023 19:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TgpXc4yO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4021C86A23; Mon, 16 Oct 2023 19:37:45 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E2578634D
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 19:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697477857; x=1698082657; i=xypron.glpk@gmx.de;
 bh=8imaYpkJam/DoWdBorSkcgFNHtf+nHS2/bXfVFkpQlg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=TgpXc4yOppFimJkiedBsAZKwhEjC9Pusu+3XiQjtoteUXkeKpgi9+cpSyTXqPJ6d5F2oi4X1tG+
 KGSy9rMd3E/PPNuynvRcHtmFEu2uKN5O6Ll6BRP3om9APdG2InpPsGndHInyT+ulWPRjR7qozm83a
 NN/YsgEXLJUoki0dVazdheqP+fIpuFXS5sERK9mZqk4PypDHeUq7aEGH/2x6JvuXoYoXgBn7LolTF
 hddctmhfXBJtS8PjDsPV9eHJ4Vz3u5WXZcv4u/6dl1LgDiGis96bwOJOzyCSa2sMdYhKtfVj3Z+Ky
 9JHuM3mSxz+IA7KH1tx/CAlXTqz1WZYPo/dQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4b1y-1qrtIs3IaU-001kkM; Mon, 16
 Oct 2023 19:37:36 +0200
Message-ID: <f0a97e3c-3a9a-49a3-921a-0fcbd2aebd93@gmx.de>
Date: Mon, 16 Oct 2023 19:37:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] sysinfo: Add IDs for board id and revision
Content-Language: en-US, de-DE
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
 <20231002152142.76516-2-detlev.casanova@collabora.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231002152142.76516-2-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RdUi+IYrd8i6bZfeEq7awsmSa51knDs7GN6oh/xA9zXxWqjUJUZ
 NwmCvJ1uQs3tZicY2VGMeJRuOF4AuD/Mi5Z2e92inUhefJnrOTJe7LtYcQ4svOGydK8hIW7
 PS3TqZvhRcSR1F1CsMg/ZvBZS9d5Hz91C3e7oaCr3VEDHOK8nmlllYrDEROyMQRmTuBPkHH
 2Coha/f18q1CP90zLjuiA==
UI-OutboundReport: notjunk:1;M01:P0:I84jswS1LQo=;V1ccAFJ+G4u7JexfFtfIZGgOfoj
 tbPb15HACJS6O2xv/oMLJA9V19GXIwC14GqVjZq8woyyNSm7uIhMNQAjKXHaSas+6QVxRqBaT
 i3EG0YgB0CzY+Fqx/STajkuS9DP1HvJjyPVHy2uN5wVFcbF9pHEXmI6CSHgtk83KbxyABxpIm
 Us7deD3R8gezfWH2AYg1PTetik0Vbvesh7q1sIMwQx5KJ0xEzbXbJcn2BnKIJud3LKC3eheUV
 H0MeBdBVUW4FO2sOTOJxrXspE2Xg5v1xYuvQMx6q5/UhetPmRN3w/R7q3c3ILTjjQwC5lGqLO
 +2y38AsE3q61i8rBld4nvXH7kLBEwQ5bKblyZLwvmwt1fhiYUhVJfUJoOmyKLp67T1IFvMFkE
 A3ny5ZDlQ8qwZxIAFdRG73P48qShmTXZ5NiCwOUR9nW0IkfxsykhWLHePCCVPX3Pc8XqoN8UZ
 /zHYxud8URxqPcSEexsMxKMmmMrFvO4NK9lOB7nH5Xl2gio0nVYrDftpKDXh4F7JEEDDEDHdT
 6Rxhe7e7SwXWPkPSVKZjKCLcpUof2ml9TGiSBAORZGkqdUunf8vWwrGSDU0rWdWh4Il2+oNqB
 jTqMixQI3klU2dVZzto+VbkGBOoIRMJCtN0qd9DKjulhrtn6Dc15ZbZJkwnSCpw3NX1AEyzMI
 BukyFOQqrkSUTGPce2g9gjUWYwtraXUrQsypfZE62bYIuquTiklYwFAiS1jSGblblauUa2T5Z
 Fsry1+F+HlXQgdNgMhIbSSHEYTjmdzrP7YT2S16wZc5XrgaCCjWI7k4rPDS/MCpP2RvHqkxUT
 DdyyNdcrE93NheQWejh9Wzzvi+HJ7TVwPYM9k5+zkCanEBXxagyW0FvytaKwirg/DCuFzBzGj
 8ZlTZU2MKl1jQaojFVcE+ueOwReEN90Ro/zdKp2GPLgirWYLcuyX4dDkDOhB3Fl182HbIDz5h
 MctE50bX3WgiePLFDOzMdkDe2eQ=
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

On 10/2/23 17:20, Detlev Casanova wrote:
> These IDs will be used by the sysinfo command. The new IDs are:
>   * SYSINFO_ID_BOARD_ID: The board ID as an integer
>   * SYSINFO_ID_BOARD_REV_MAJOR: The board major revision as int
>   * SYSINFO_ID_BOARD_REV_MINOR: The board minor revision as int

Integers will not work in the generic case. E.g. for the VisionFive 2
board we have seen board revisions:

1.2A, 1.2B, 1.3B

For the Wandboard:

B1, D1

>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>   include/sysinfo.h | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/include/sysinfo.h b/include/sysinfo.h
> index b140d742e93..13815600ae6 100644
> --- a/include/sysinfo.h
> +++ b/include/sysinfo.h
> @@ -47,6 +47,11 @@ enum sysinfo_id {
>   	/* For show_board_info() */
>   	SYSINFO_ID_BOARD_MODEL,
>
> +	/* For sysinfo command (all int) */

Please, provide a Sphinx style documentation for every value. Cf.
https://www.kernel.org/doc/html/v5.3/doc-guide/kernel-doc.html#structure-u=
nion-and-enumeration-documentation

Best regards

Heinrich

> +	SYSINFO_ID_BOARD_ID,
> +	SYSINFO_ID_BOARD_REV_MAJOR,
> +	SYSINFO_ID_BOARD_REV_MINOR,
> +
>   	/* First value available for downstream/board used */
>   	SYSINFO_ID_USER =3D 0x1000,
>   };

