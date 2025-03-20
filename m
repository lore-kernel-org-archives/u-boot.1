Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE360C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 04:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D610803CC;
	Thu, 20 Mar 2025 05:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742443513;
	bh=hUxRpJwePcXkcdmrrHQ/mQwaPK+EnhU3vvdE3cfpdBQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ye+2rNXUYfmDVX/A/eCHKHPS/L+oC35Dgeh87b9Z6nWA8e5crK2MRNzoowAGubRTE
	 eZXw4gslT1epHy7aJsZi/G+ICs4+7Ezhh30ExkKDqauGb4Oq4vnXOSgIbl9rZbwtze
	 mRU+WDSAoI3J7P0GmEwfiIC+/11SZDmNNo+Ok2s7MNglzVl4W8dro+5qAdMAKlWDWv
	 ix0bB2Gze2YiiSMesSntEnFyRDWXlFIBhiGM5P7gDUNUXniyRAVTi7XgckAuJvGx9W
	 w5xWojb2dz+EJ85vN21MqKh+GlUzEJTWdU0pIvOMJQ2OXjwPirvPM6ac6JkaKX5lSz
	 pGbSf2BB35R2Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B049D809D4; Thu, 20 Mar 2025 05:05:12 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69D7E803CC
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 05:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="X4vF1O6u"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3583D101E91CA; Thu, 20 Mar 2025 05:05:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742443508; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=hUxRpJwePcXkcdmrrHQ/mQwaPK+EnhU3vvdE3cfpdBQ=;
 b=X4vF1O6uvn0NCIuC/Zk5sSzyReDwP6Otoqel3RouyXq8Ge1+Iuv0GHPk8Lh1u1hyXXneXh
 fYZuzsa1Kqo1DsmfPXItsbgtUw87y8uvFQ5tQ8VDaY4zPvgU7lF0wq3dnvgoG6V0Y3msOD
 LyLgliguwwH0k+VbTt2sbHOXbsm1rzihGJSgYx0P0/yYUCO1Elw1DUxAfDfsEX3M2aDhLi
 11sZGAP9Zl2j40WceklTNePhL2ghMlXPvJmlmqVEOijsBhFaZL6441Dru3vRQHqj6S2suT
 7n1EPNY5K3pb8nBU/WChf10Vy44BzyGWRTGYJXB1UsapwN8fPIGFZL2cWb9K2g==
Message-ID: <5bec35cc-99b9-468e-bc01-1de5dc39825c@denx.de>
Date: Thu, 20 Mar 2025 05:05:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Simon Glass <sjg@chromium.org>
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Brian Ruley <brian.ruley@gehealthcare.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Tim Harvey <tharvey@gateworks.com>
References: <20250105203714.158480-1-marex@denx.de>
 <d9a39908-b614-438c-bfc8-34027a27db72@denx.de>
 <CAFLszTi0BQwyxOaMFCbgRAzFyBtcY__bXjAHkqZECLRJNW4-ng@mail.gmail.com>
 <ff692c58-76fd-432d-a73c-191e6e753d9a@denx.de>
 <CAFLszTgHHtNzPONVhz4ZrsZqUb2Cz+CeaaNpggYpUx93=TwdRQ@mail.gmail.com>
 <cc2896cd-eb08-4c26-b86c-a4f37ccf70b5@denx.de>
 <CAFLszTh6f8efphOYgv7wMU=z6zt0E=uiG6RK5O8hE=q1WtEhhQ@mail.gmail.com>
 <dc010565-03b3-48f6-85e8-1b79e17be14d@denx.de>
 <CAFLszTjcdFKn2ayTrLx930b+P5ebBfX_EE8-aS8sOJTBsqQKHQ@mail.gmail.com>
 <8647abd3-9378-42cf-a1fa-302c7891d439@denx.de>
 <CAFLszTiw01KB4ipwqi1b64A4MP3SyU=zFRymV4moiJ_nBtnHRw@mail.gmail.com>
 <a05cf63b-820d-4b27-8f66-37a6e6c7b372@denx.de>
 <CAFLszTgF+g2OXz=L=r7rOQcNkk19GfdCrwixG8ZAsR=1rh9Fqw@mail.gmail.com>
 <f1e4014e-658b-4a47-af8d-72ef76c1b134@denx.de>
 <CAOMZO5B7cxEftN0TeTF--pKXqOmbmaFLc9mEPO4=8odrLBeypQ@mail.gmail.com>
 <f71762e5-ba15-43ec-91a3-dbdc8f8e1437@denx.de>
 <CAFLszTj69OUZj9ZBcmnsiLLvxCB+Y-rJYEW_Ep8V6WFtvXP2Nw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTj69OUZj9ZBcmnsiLLvxCB+Y-rJYEW_Ep8V6WFtvXP2Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/20/25 4:40 AM, Simon Glass wrote:
> Hi Marek,
> 
> On Thu, 20 Mar 2025 at 00:54, Marek Vasut <marex@denx.de> wrote:
>>
>> On 3/12/25 1:41 AM, Fabio Estevam wrote:
>>> Hi Marek,
>>>
>>> On Fri, Mar 7, 2025 at 2:42 AM Marek Vasut <marex@denx.de> wrote:
>>>
>>>> So what should we do about this particular patch ?
>>>>
>>>> Should this be applied ? Rebased ? Updated somehow ?
>>>
>>> This patch causes a CI error:
>>>
>>> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1057151
>>
>> I think this might be what Simon was pointing out, but I never got any
>> suggestion how to solve that.
> 
> There was a patch for this...and it looks like Tom has applied it:
> 
> 19a342f9122 Merge patch series "binman: build_from_git: Add argument
> specifying branch"
It is in u-boot/next , but it does not seem to help ?
