Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F52C282C1
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 15:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B07809D4;
	Fri, 28 Feb 2025 16:46:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="eoqCI68P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBE6F810ED; Fri, 28 Feb 2025 16:46:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF5A9807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 16:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740757606; x=1741362406; i=xypron.glpk@gmx.de;
 bh=UH/3jgt/wOSR60zDEIzU9ZHtRzM/dtSQVtD1LGHvbqA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=eoqCI68PHQz61qg6+YsC7wJh7bshCGK2EZ2UYaSGf3znYdgi5O2aQDSm+oO5rvcm
 PF2mp155m4NxQhSx2A+ak3dI7p+meBJBkiIqGNs/sKaR20dBDbLDkQj1Xjl0t9Slu
 rbBZyGUGAUpsM3YfbOIqJUypRuQ58MRXN93CgR8d8OWooEiALf4nitKdWIJnt/f+8
 eeaBSwdVNSFyX3hlb/UxvWFnYuBQthIitdc1TsyJoLiFQvrgr0RnzV2CJSg0s8xH9
 /zdHbcU0szFMGTicBSghSH+NXf9zOOxFulYPEg3rYJBBsWC9fMZLDr5Rec0WEJYQl
 +ESCBThloW3l+4G5jA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDNf-1tVUXB0Etr-00nx87; Fri, 28
 Feb 2025 16:46:46 +0100
Message-ID: <84a24111-d03b-447a-b451-e95fe3e7736e@gmx.de>
Date: Fri, 28 Feb 2025 16:46:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] xilinx: dfu: Fill directly update_info.dfu_string
To: Michal Simek <michal.simek@amd.com>,
 Jonathan Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Udit Kumar <u-kumar1@ti.com>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Daniel Schultz <d.schultz@phytec.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Aashvij Shenai
 <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Tom Rini <trini@konsulko.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Lukasz Majewski <lukma@denx.de>, s-vadapalli@ti.com
References: <20250226223547.393611-1-j-humphreys@ti.com>
 <20250226223547.393611-2-j-humphreys@ti.com>
 <26b269b3-9df5-4ae4-876d-ab41aec6baa4@gmx.de>
 <1a85dacb-9e84-43f3-a223-5a5aa7e68179@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <1a85dacb-9e84-43f3-a223-5a5aa7e68179@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d5FCAKNnKmvOgM8nD9fJUPhXWE0HbMmmibyk4Vy0fhMwI0sESgy
 hDRb+XSAwjIzgw6XynN0rzYNMeyHEEBeRFUIMSEdjrudJuHk0HyL5maqdoAzH9Z5dbXo/ZC
 OJ2Pew9lgjO195F6HVBGMYzI+yQ3Mz1Gt1cLVH5ZCGQmMlet/vAnLEn1phMvbLKn659Kqps
 jzMDwRaDAXBXZtBJejSuA==
UI-OutboundReport: notjunk:1;M01:P0:kENxACsNJbI=;3rU3+AiCDvYMvb3PCMECqu0Y5OD
 Dm0OxFa+RSWXAsEE0GBdYHZu9iymeWOQO4sAkHEi/AMXpr/swvJ0AIIlZhUvMHXouz06txw0n
 vcR1qC/pUPKUbpTFlrgVjv59VAKvcGTxDeJ9AJ45Gsr4LFyZYil9/9NEeweUuQotjtP0TSHsy
 BhvtCXKlBSaHYJVzYdLh7jfcYOIBXuE/OX8MTDYSqIEmaQ7AEXSnur14hoHixUEPR7/k19etK
 n+40Hu7NfhbE+wS5tNzkgw7nmxLE0Rmfn9Xtxy0F3G0czW4nOacEZu6j6r8EUnzCfitJf8s9z
 vkNwrp1Tyjzz0M7LjkhSiy5UOnDdGqr3tdIdjSCOP0QaEdk3WDuH3TC+LfWywqYO0NQbXBLf+
 YzRF665Plr1kgh41FJLstSw+fz7CBQ4SqKZ8mLYLVLJqjzu9jkLQWLox2ZoWeLQtlAKgf6B8I
 J5DUn3QgjOFRmxnOTDeQhoAk1nSnbTBER84OhANyPkbE09gHyu9zU+iSCDookRztT1QLSNlBU
 3BCZUiwb7/5woiAxMTIwh/094/hAoq7hBGZgwMzTX+BPsr9+GFVg7q7W460NwMP5rTDa0//hk
 heIAsAJOfk6LOlowKSe/MntMgQtLOhZuRYeTL/HuNGMk+chwHE9NbiPQiqp1cxbGp1s1SS0j0
 nurbveKoTOj61akH6mPr0pi0/XucqV7NDZP/sJvkBYWePDUYF0ynKmtotKAyB5rJ6pcmbOunf
 TVdUZrIih2XGurRg2C2mYns23D3IKe/tOaZ/qZgb/TvbyyXpkp/QcjOGAUaoHZlIHW4dDvwE6
 OLRIGaQwz0aIpO38JTxK16rDTNJ5Fq3o3xp5Bvq0vzNPFM4R52/pOLnRJOweJ2YaUSxdHPgN9
 YAeQ3aMirHGivU8M5My5A18l+Nhcmi5i8L1tgsYRiJyNZTXXjasoF0W/IZIOAYhrlrNg9te39
 avVqB94UP/KeapqqtJKEqCXzcYlq9bIh970XK2GZnnWNL7B0IzpSsJlnehkkWJytTOD/+UTWW
 pB6dAVr+ILWdU6RwvKwIbbOMoBdKQj/DILqbmoCv6zdvZrAjZxuHq3tb3xDwSC7HgLmzD7eRZ
 mHcvtXAv759e/yPfwzuiYNCXpe2nBd12tpuDE/030TZx24nnG7PNfNywk1FIUg7RBwEYV/qka
 T9DTP2ikD9BXVkQisJ0W+A8sYYkitN7n0S+PS/D//qFSxIaEJxiTc9Y7N0NgZP3S/B/JdvNIg
 oRer/f66XnpDvEFUjouuir7hprPr96GNhZQC1oTeg3fUtq+j4MwjDu835jaifE8fRFALDr0PN
 YTZDlcUkU/GOvEsvQyJO8r4aqDZ4NEBEZULzmbHejfME4aQQZoIsY2GCgi5rYl7XEgBTvbDTL
 SItshRWSG8LlkeF9X5/mCDLzz9+51lHdGKpaLD868sCmiOoZQa1ugWHT4X
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

On 28.02.25 16:41, Michal Simek wrote:
>
>
> On 2/28/25 15:33, Heinrich Schuchardt wrote:
>> On 26.02.25 23:35, Jonathan Humphreys wrote:
>>> From: Michal Simek <michal.simek@amd.com>
>>>
>>> Directly fill update_info.dfu_string to prepare platforms to switch
>>> from using dfu_alt_info variable to dfu_string which contains
>>> description
>>> for capsule update when switch is done.
>>
>> Other platforms only set the environment variable.
>
> Not really.
>
> git grep \.dfu_string board/
>
> beagle, imx, rpi, ti and others are also doing it.

But why do we have platforms that don't?

>
>>
>> Do we have a problem that needs to be solved for all problems?
>> Or is anything special about the Xilinx platform?
>>
>> If we have a general problem, solving it for Xilinx only would not be
>> the right approach.
>
> This is just preparation patch for switch in 3/3 because then Jon would
> have to do this change in his patch.
> But the biggest reason is when 2/3 is applied, capsule update will stop
> to work on our platform and I wanted to make sure that we can avoid it.
>
> Thanks,
> Michal
>
>

