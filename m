Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3E5C46CD2
	for <u-boot@archiver.kernel.org>; Sat, 30 Dec 2023 23:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A38187710;
	Sun, 31 Dec 2023 00:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TVKYSPIb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42EEE87719; Sun, 31 Dec 2023 00:55:02 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51840876DB
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 00:54:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703980495; x=1704585295; i=xypron.glpk@gmx.de;
 bh=bZcLOVjzT63DbrR+ZCPqyYA7JHdbLLmMW4jtyUQUgZ0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=TVKYSPIbLOhHRxikavkImqz3P2LpgHDNN4b/x035AKV/tZJWp/GDhGgxngX07Twj
 RNQ9VwQWKSq7ciCXtOmNPd8eeW2vzvvklc3hDCjx0zpmeOjQqGaak/gZKJc3PwxRs
 dkwe0OyqBwCxLMy036cxLvAyy3XDuEqdUrBo52VB/8OU4P49Akfs1VAggJwX2cwor
 S2uVPidbxkGNOa99kmmfp3uXVu+YPv+Z2uS0O9K88pddOSVOD449TOYnBY4rg1pXA
 RlQGKJnJHQfioAyXqHQcmUtNBkAvbEdrNsOuS9bUg8/5Z2HWGd5ZFAqg72mzdimwv
 4dwrX2Fhe/7OHx4v8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpNy-1qkwZx36Qs-00ZwaO; Sun, 31
 Dec 2023 00:54:55 +0100
Message-ID: <514fe736-5122-41f2-bb1b-ee1a42ec2cb2@gmx.de>
Date: Sun, 31 Dec 2023 00:54:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Passing boot logs to Linux?
Content-Language: en-US, de-DE
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <Csokas.Bence@prolan.hu>,
 Daniel Golle <daniel@makrotopia.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <ZYH-K_UGat0yWMVH@makrotopia.org>
 <CAPnjgZ3sNBuaNkbTF2d=E2JD4sQOaA5QRfzDfz1KSV==nOWbTw@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ3sNBuaNkbTF2d=E2JD4sQOaA5QRfzDfz1KSV==nOWbTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EdWe58syVznHfD7tLpC6wywFN/1LOG0Tas10rWFxikZE46eqep0
 8OkeuYPio4AU2s6ff0UejBPQ6C4aZUiz5lJ2Qyy034kqJaVJtm1hbhqs8HwqVP2iSy/KdN3
 8/zzr0pj0CaBzsyP7muXgSUl57jTFnEs6DeWVVZElh/C0k9HYJTyCbYCKXooETkS8ruyYQP
 DZy+uIxAWduF8l6J9tLlg==
UI-OutboundReport: notjunk:1;M01:P0:og5rYbsPS+I=;x/bJ7h+8Z4V73aCUllslGIOfoyE
 jGKvboZz56U3R4CtiFnEFvuLtbAbcGNhP2NKNvbUBCrCUaz/cvdDo8DhnpA7Q4irrVrvjYqxr
 DunV1+8e05HSci2GBy6xEWoI4TWvZi1Le+oKI+pPr5PESOPPGt3p3Ctfm5it55tWCI2jwyOZQ
 Is5LIRmuAAZXRb4HI13QYCIpmkUc6xBifJ0SEcp5nzcn5FBPi/tg84kjEqywjSPHxuE/xvN//
 +92IF4FYfnWeWNmUqR45NlUuwqrADFFzUfusH9n0MTfnsXtXwd6I9ri5J6iFGo0+Rg24lMcjT
 G6x9V2xhK84vP0vmxH2Vlm9uOql7y5vf2JetMyNYo7JhFWnQF9luHqunovVtFdTjjjeqZR7S6
 oKdpSzRWAcbtvTMDQATGBjUbiSZDCwMAZcm3xL85CXsWN4IVXOOPlvUZiWDqC//8SnvdY1jSQ
 vxATPhaE5uARMPUrWCQo2sEc0JPtPsrtkJ6+oFtdrD8F9BYcQmrRuO64kicmGkfIzE+cxoSZz
 +XczWkRo2OtBZIstphAsYkyOTO+G8r1EPJMhM4M95f6/wGYn8dEL6e6jUAmtts3W7vYInKABd
 eNqpTvM1/IzB4++hyCFpU3/neLPQTe9SMFEwksIEaY+oHPyLntLBzZWUvpeqp7Rkr29dkXDeZ
 +9gJ7fvWcLkiIrB1N0gTx/kl42NeCfRCtGeZX8Lh6ZER7jtQ/pbVEfjPZPji5ff1D6r3rLVMF
 btxO3p5iRg+lXgW9sW/+q0N4mr2cMQED+ecj97C3x6nh/W8gd+jzjImnKuejzJvHww4ff0dq+
 cAsietmBRBUW3O2eBAqga1qS/o0PJaPuVbq/c9F8SocHGlwFJlwaQbO56m1oPrw+Iie6jCwR/
 sLlEmvqaeqowe4jucz4YvhafT1b8EjhPvLeZfAoafvT/cN2gbceXs5mD0V6wTff19mzWNqsdb
 bw5DKsVpd/XitAxxb6hFbPcrbdM=
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

On 12/20/23 05:11, Simon Glass wrote:
> +Heinrich Schuchardt
>
> On Tue, 19 Dec 2023 at 13:33, Daniel Golle <daniel@makrotopia.org> wrote=
:
>>
>> Hi Bence,
>>
>> On Tue, Dec 19, 2023 at 08:08:48PM +0000, Cs=C3=B3k=C3=A1s Bence wrote:
>>> Hi!
>>>
>>> Is passing the U-Boot boot log to Linux supported yet? We are working
>>> with a third-party solution, which works, but is a bit hacky, so I was
>>> wondering if an official solution has been merged yet.

U-Boot supports writing log messages to an rsyslog server via broadcast
to UDP port 514 (CONFIG_LOG_SYSLOG=3Dy).

The device name can be set via environment variable log_hostname.

If you have a log server for your devices in the same network segment,
you can consolidate all your logs there.

A driver writing log messages to a file could be created in U-Boot.

>>>
>>> I saw that there was an option CONFIG_CONSOLE_RECORD that saves
>>> everything to a membuff, but I don't know if that can be exported to
>>> Linux yet. And if not in the tree yet, would such a patch be welcome?

It is not enough to export a memory buffer. There must be support in the
operating system to read it.

Linux supports the common platform error record (CPER) format defined in
the UEFI specification. See

* https://www.dmtf.org/sites/default/files/PMCI_CPEREvent_Proposal_v3.pdf
*
https://uefi.org/sites/default/files/resources/Spike%20Yuan-%20Server%20RA=
S%20and%20UEFI%20CPER_final.pdf

Boot errors can be reported via the ACPI BERT table. But that won't help
you in OpenWRT which uses device-trees.

Best regards

Heinrich

>>
>> To me this sounds very useful and definitely something we'd like to
>> have in OpenWrt. So I'd volunteer to review and test your patches once
>> they are ready.
>>
>> What comes to mind is that CONFIG_CONSOLE_RECORD also captures ANSI
>> sequences during menu or count-down before boot, so we'd have to either
>> introduce a dedicated log_printf() call and use that when ever we want
>> the output to also become part of the log buffer or we could somehow
>> filter the recorded console, eliminating all terminal control sequences=
.
>
> I have been asking for this for a while. We need some sort of inline
> function to enable ANSI output. Perhaps something like this?
>
> #if CONFIG_IS_ENABLED(ANSI)
> bool use_ansi(void);
> #else
> static inline bool use_ansi(void) { return false; }
> #endif
>
> bool use_ansi(void)
> {
>      return gd->flags & GD_FLG_ANSI;
> }
>
>>
>>
>> Cheers
>>
>>
>> Daniel
>
> Regards,
> SImon

