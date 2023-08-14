Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726B4C001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 15:18:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAAF986722;
	Mon, 14 Aug 2023 17:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CcLloqbi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C8D1867B4; Mon, 14 Aug 2023 17:18:34 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D54E86679
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 17:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so596944166b.3
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692026312; x=1692631112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kUTq3fbxIVVgAcclry5dCElJdOhlNBHpw72pV1hEJgs=;
 b=CcLloqbioatbA1fr2MdYQe4/q6MQf8AdZ3jFXAUmQCGMDoAXFZs2R/bphZQSMs/QvU
 mqDEFzs0b8OCi4dCSqoHPwqNssIxQVg6wZAYuy1RhHiyg8PlxcHMeAUd6NV2wgy3rBBi
 wXMDWQ+p1fNDufE+vDUM2Z2dtZAJ5299R3YdZkum817Ot9og4Z30FjOTWTyeqMqtFsX4
 HdqnIWQxDzmDiMcbNJbMQnqbQG3th4CfkILzOZIiAiF20UMwMi8F1mOQQLKwYJR+wEu4
 2bSuPI/0hJcu3J22Hbz9R6242L4pWCt32EbIpI0F8OFWCRVkRAuJPTQeToE5AmUaV0vi
 Jaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692026312; x=1692631112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kUTq3fbxIVVgAcclry5dCElJdOhlNBHpw72pV1hEJgs=;
 b=KC6xUWlsCKZEDOibjbd0LTp1jdsivzO7RZ6agOUywxzPNCWFN81ggC2zBUiz2mPyOk
 se+dcd0/UaDxxECUvVoxpWh89lXTuRsHU+U00pbXpfrWUB4hklCaWKQtGTCqJ9jX2FaD
 CkCPiXfsKyNd7IDsePR2MB5R5nGzQOsSUU5bV4gJMAQPACXVlZLBTwqyDOsUk2lK3M2m
 msReoQWuQk6pJctkRmuPxTfo8sfHxER0m3BMOT+LDNc0dsqSfdgR2l+RSz+iR1SpOjXj
 4d6mxwdfNr5BUJpVJZFs6cH+xkIw/yxL19FOafkU0P2CGAeFCvFbnnX9/TdZO+JcahTh
 YwGw==
X-Gm-Message-State: AOJu0YxEDePz3ewwuo8nEPA2mFJWGsd8C0ELv4o7IpYSe/f1H/d4T18O
 OpvhgKOEd9H6Zt0figLkYsbjrRL+5zsNN1WeBESWdA==
X-Google-Smtp-Source: AGHT+IEYYZ9Q+kM1rWDCy/cjaucbeaK5eNUoPwBu3kQW+uZ3smEZ4bhnjgX0a8/2nCsvvVs3eJ1byeq1rKHH7fejJc8=
X-Received: by 2002:a17:906:3d21:b0:99b:c952:309a with SMTP id
 l1-20020a1709063d2100b0099bc952309amr7462863ejf.39.1692026312035; Mon, 14 Aug
 2023 08:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-5-maxim.uvarov@linaro.org> <ZNo4cZtrSXa1dKXd@hades>
In-Reply-To: <ZNo4cZtrSXa1dKXd@hades>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Mon, 14 Aug 2023 21:18:19 +0600
Message-ID: <CAD8XO3a3N1j2G_Fjiws1S7praCDtLup=nrv4po--x6JmKKCfjQ@mail.gmail.com>
Subject: Re: [PATCHv6 04/14] net/lwip: implement dhcp cmd
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@redhat.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de, 
 lwip-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, 14 Aug 2023 at 20:21, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Mon, Aug 14, 2023 at 07:32:43PM +0600, Maxim Uvarov wrote:
> > Implement function for dhcp command with lwIP variant. Usage and output
> is
> > the same as the original command. This code called by compatibility code
> > between U-Boot and lwIP.
>
> Same as the dns command
>
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > ---
> >  include/net/lwip.h             | 10 +++++++
> >  net/lwip/Makefile              |  1 +
> >  net/lwip/apps/dhcp/lwip-dhcp.c | 51 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 62 insertions(+)
> >  create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c
> >
> > diff --git a/include/net/lwip.h b/include/net/lwip.h
> > index c83b5c8231..2f035280eb 100644
> > --- a/include/net/lwip.h
> > +++ b/include/net/lwip.h
> > @@ -15,3 +15,13 @@ int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int
> argc,
> >  *         Other value < 0, if error
> >  */
> >  int ulwip_dns(char *name, char *varname);
> > +
> > +/*
> > +* This function creates the DHCP request to obtain IP address. If DHCP
> server
>
> Sphinx needs something more, please check the existing functions
>
> > +* returns file name, this file will be downloaded with tftp.  After this
> > +* function you need to invoke the polling loop to process network
> communication.
> > +*
> > +* Return: 0 if success
> > +*         Other value < 0, if error
> > +*/
> > +int ulwip_dhcp(void);
> > diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> > index 6d2c00605b..59323fb325 100644
> > --- a/net/lwip/Makefile
> > +
> > +static struct dhcp dhcp;
> > +
> > +static int ulwip_dhcp_tmo(void)
> > +{
> > +     switch (dhcp.state) {
> > +     case DHCP_STATE_BOUND:
> > +             env_set("bootfile", dhcp.boot_file_name);
> > +             env_set("ipaddr", ip4addr_ntoa(&dhcp.offered_ip_addr));
> > +             env_set("netmask", ip4addr_ntoa(&dhcp.offered_sn_mask));
> > +             env_set("serverip", ip4addr_ntoa(&dhcp.server_ip_addr));
> > +             printf("DHCP client bound to address %s\n",
> ip4addr_ntoa(&dhcp.offered_ip_addr));
> > +             break;
> > +     default:
> > +             return -1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +int ulwip_dhcp(void)
> > +{
> > +     int err;
> > +     struct netif *netif;
> > +
> > +     ulwip_set_tmo(ulwip_dhcp_tmo);
> > +     netif = netif_get_by_index(1);
>
> What's (1)?
>
>
Only one lwip netif is registered. 1 - here is the index of netif. I don't
think that there is any definition for that...



> > +
> > +     if (!netif_get_client_data(netif,
> LWIP_NETIF_CLIENT_DATA_INDEX_DHCP))
> > +             dhcp_set_struct(netif, &dhcp);
> > +
> > +     err = dhcp_start(netif);
> > +     if (err)
> > +             printf("dhcp_start error %d\n", err);
> > +
> > +     return err;
> > +}
> > --
> > 2.30.2
> >
>
> Thanks
> /Ilias
>
