Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B0BCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 13:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D1DC86F79;
	Wed, 18 Oct 2023 15:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cv6+CSej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DB5886F79; Wed, 18 Oct 2023 15:51:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1C1086F40
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 15:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697637088; x=1698241888; i=xypron.glpk@gmx.de;
 bh=Bj44Z8bY7NzIyu7usyjS7Ma82cE/Yuset1zbLfMjgwk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=cv6+CSejSIC3ZkFy6/nohO0SQHcEzRkJltBs0BqqRHQY9bQxKqACaPWij6StrHwCO0pO4EIcucL
 waTukSWErGWOl60JzEj3f3rinsUOKQWuxRaEeRrs3BRChH5NRdAXVvRcH1c4oaPULhNe3pNe+YtNa
 n8rR+tjuO6Na/UJKGnhCU3SGncIjdA0IetajFZaw6fV15/3eH9hYnFnfhxBF4cs7qv+lXcDSckq3v
 tydypkHUDa6BTdegQn3gDPXPaTf3rL2P+PyA6apifGqOjZA6XIOljYAh1MrTpBbnr9YdJF++/+jFp
 2ET7SAbeMwxbmaztD2AQqGggdzAFHoY9/0iA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7i8O-1rejQY3BSM-014mMd; Wed, 18
 Oct 2023 15:51:28 +0200
Message-ID: <8ce172b2-8665-442c-8e41-6b36f1255e5b@gmx.de>
Date: Wed, 18 Oct 2023 15:51:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/32] sifive: Drop an unnecessary #ifdef
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-7-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231016222835.596572-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rgvbvx5AH5fWmyNJa36WepeJPN7GhUUcGpX0jktTLBR2ubicEDV
 MBULz2y1Q4TG/QXYS4aP+++j2P5gghxVc7OSfW4g2NG2vAHX5ENrJ0UGaMmezwlOmn2KMhY
 ToF7y45zrDs9XHH1HuP3RWoTiDX3ODIUWpq5jVBo/ApiAq2gCy9DCvq77FuhLFR0chBmXEu
 ip6cWuTyNAwG8QJ0lXOLg==
UI-OutboundReport: notjunk:1;M01:P0:VEji8gjpa60=;CpM71WOxgqBtNud9X5gUKeqLNCJ
 vBP+y3f+Q5i97VJ3b45t1it4INYPduus0V+eaXNMhkFNWjEl1DjKVPpcL6P6W1+z02KNhsoIx
 CWcl2LLwEhkstS6rf4KwzNdLHM8TwgsQnZ5rGP5kuI3+Zs8XfZBhrci3naGCV8nAeYAd2nVo1
 uArw9i1rS2gyiHx706gMPU3s5SOLnKysViJA8/bqtHRHuTjtgyeq3iiCo/2ZQAmfRU/pj+Ug8
 Cay3cC2tjOXZCzHCOFLRGXz80BCBcvryJCoIQBS/wvzNYbA0lfOlBC9kPymhT/mhJzyWVd5iN
 zkueTwCipCgn+dgzXwEaiTLCh76SVb6HoQX/L5D/iOCfzjs4tdqkj9AYBvDqXs0B+hkLJjI4L
 Zbuon6hbvtn+cl6JgiFQH6HKlb1rN78hjZsj02cGwqTAAbsS2i0EBqsY3mGOH9YAf64e6wbGD
 jjJO3jLUrKJ8Qlsu7+Rtgy6cK3WB2Qg+ZMiZVXESVxrkOdwkCxlY0r1Ni3SZaR2NwLErqR2JS
 bpK6sjbKXPTc/zZSk5IO//tFO4q5pmAwMv6Oo1ctA9nBKVZBIJxX/wdmpnxshS45NZxBHNmiN
 dIZGSR1YtJqYRrXU3AvuqvarXs1Hf8HSWhOtEySzTB6gFnrJMxNFjV4GBf0u9mo2A2K3stZnm
 ghSoQCmUdDjQCRLUKwikV7xpOfmo5VyXVQ9D5tKWbZfZS5Tagj5LFhhTeYpmvHuP2c4zyw7Ai
 oRwics6VTj4dJcaC5dmaQxIt96U2P48v/8O50P9kcCTtC3DFIFN2Qz2ZrigbfDwtgcmm72tEg
 NyzFLDdx59bjzROP0f4eWzDAdYL0NQc2CVT7RZ5IBGkgjsvz/NG2hGmQ1y3bmFkW8bdKeElBP
 y9kuBkwmWqv9cgGTUC26pAaXc8KJ1RtKHLLAmWU4EKIkWFKF2QVNDwCFJAX7GPeijKYYHSY+J
 69jeKFfzKAoghwy69qtWLoz3nEM=
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

On 10/17/23 00:27, Simon Glass wrote:
> This code is normally compiled for sifive, but sandbox can also compile
> it. We should not use UNIT_TEST as a synonym for SANDBOX, since it is
> possible to disable UNIT_TEST for sandbox.
>
> Drop the condition since it isn't needed.

This is not what the patch does. It introduces another condition.

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v3:
> - Just drop the condition instead
>
>   include/k210/pll.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/k210/pll.h b/include/k210/pll.h
> index fd16a89cb203..6dd60b2eb4fc 100644
> --- a/include/k210/pll.h
> +++ b/include/k210/pll.h
> @@ -13,7 +13,7 @@ struct k210_pll_config {
>   	u8 od;
>   };
>
> -#ifdef CONFIG_UNIT_TEST
> +#ifdef CONFIG_SANDBOX

We should be able to compile with and without unit tests on the MAIX
boards. Why should CONFIG_SANDBOX have any relevance here?

Why don't we make k210_pll_calc_config() non-static in all cases?

Best regards

Heinrich

>   TEST_STATIC int k210_pll_calc_config(u32 rate, u32 rate_in,
>   				     struct k210_pll_config *best);
>   #ifndef nop

