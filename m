Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A026C7EE39
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 21:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE14F82B34;
	Sat, 28 Jun 2025 23:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pGNbR8KX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F59582DA1; Sat, 28 Jun 2025 23:23:11 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D7182977
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 23:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751145714; x=1751750514; i=xypron.glpk@gmx.de;
 bh=V/VI4nHx9I8Nta4hzXX7XLX+DbtYilWnu0oWMiJlbgk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=pGNbR8KXXHm3/hhxIeGIvgfSbL2r22k7nPaPxmoG2FxWYWvjMKF+GYI7bx/uq0CD
 u+i9hgsucv5enf317sfJQzVAgmOowhKOUzmKeyH7YFkcDBn7y4wjaGErj0qtCn8fL
 cc61lMDbBzJqdNB86nc9vV924V95LDThxWkYDAZn8OZi5s1Ind/3YFr/f/x4gd/xM
 iMVaDUAs/cZfshtuEq/nfkS1bNX29zIEz/rkfBbOPb21NtdX4n2w7oDOPWRgIAEBn
 /XZdLgcYQbHSROYLbxkjm4BpM3R2oQKZ48WAwrwf8irRIvq7cyufk3hSHgtO1maeM
 E7eEc4fgNb4ZEVaBIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.106.132]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsPy-1uMrYI1RiK-00Bv4Z; Sat, 28
 Jun 2025 23:21:54 +0200
Message-ID: <a37aa882-0a6f-44f0-a98d-56ac19fe663a@gmx.de>
Date: Sat, 28 Jun 2025 23:21:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cmd: Introduce CMD_HELP
To: Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Casey Connolly <casey.connolly@linaro.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <3f2984f62d6bda6a4a432b51047eddb70e35571f.1751014184.git.michal.simek@amd.com>
 <CALeDE9ORhMR6Zj=Ps+BBBLax67kLDxFPdWtr_V99Pyy+XhuTKw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CALeDE9ORhMR6Zj=Ps+BBBLax67kLDxFPdWtr_V99Pyy+XhuTKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pZ32TpKRbO+sM9vZgzmSVwEDy+azXN3VJHLzk+Kh3t0giBCyhU0
 wlPTOE8Cm0UtcF310v6tLpvpL5Wvr3lsZ7uCC34yoB5BUZLAUFMjb7R6L9TYG2yis4Eng3U
 xROh+ij2nWLUyzuPuo+nQbEYxVQU5Zg71BEw1s1gk4aPBZPLxgdbc3A4RlpbaWwBwdyGPKv
 RBoUnsiQUDqilzQ3tHjSg==
UI-OutboundReport: notjunk:1;M01:P0:IPMeOYIRBD8=;1xi2e/e9xat7iCIrSnNy6tsUzIN
 eWP8lz+JlfTD65aj9JbKMcTgCTxDTEPKwaUUULNGulxxGFlenE8cTSSbtI890fqLNGcm7EbdI
 R+AkIAyXBHqFHA/UX0XwCNQGQmucm1xRCcxgfW3upLjZCWSMBhmIGqawn3jROF2MSz7azrSif
 Z8CQnrv15nuu9GS8CJmUf90QmcviSUOolP3/JFrTvlux/j89MY1fHBZD4Fa9r3PhezEJLEtcQ
 2BOAZDsHPQUS4LpdGJrg7tfzpS9xeGAzCIOwLJ9jfxJCjs0KoKREbssbCwaYWji6TQpV5Lhzt
 AzZYjiqqx7nByB9gor1OMWFvzQHJkPdv1inIH9wAk2MZkkQrzHaGwiSK7A9WzcEVQc3ZpYAw0
 Ad2MOwdd2cRMKYlkmQIBKE9dinaDU+uAuYb4c7/432fxa1MsK0kFXjympvRyW12cwi1INO198
 kZ67YDjQzaaBAGsDZAw9LG451Eoh3M1keGTuPhvv3U///FA7eMzC45TyMPZHqXoB1s4RWV7M1
 OA0SgFmIsVtRuFDnql0zQX4oOSX8YaHZtvG9FB6YpolzMTaSS9bAhrk5IfviWqX3APBy88fw1
 x91mHQcb8vk6Dj4mXiMSqwrCnKJjPR3Q3RE/165UtEYnWcETm7nDBsCv/DiBBF4GVRrkMuV4M
 w9p5wHErVtSw5jotXz+X5Idp2WYVSzDKr4KXn3hcpD5533/Hfhk0noBprTBKcWZcthNC6Y/VW
 fbhystkPQAffVQmwCuTWkb50n6PCvZ5Q1c+FF2iIEgNRD4OWtQMBNaufUFIEyWBB+mvMdcbD2
 SQ8W3bPFNOVMJzOjhD7oL6Ry9K3IE/y3EbplsHjzeX1kIQwsqyjfhQYVJYeTtJhYjWngWAchY
 kvPDdYOCPMvNVfk+jP0o9KgB6o5c0ulXUwnDb1ZJLNFcAD2bc6l4cfVVlQqRAHh9qgy3wQFMD
 6ea9jlIHHo70Roc83/YCY7SUDreuQ2p1+VrVvjA/9TCX0PLGUqP4U8ErwwVdMHITnjTPo25wl
 g5P2YY/sNOkbfBXsuSiDjELAWTybW/5MXOoot7qsGT+OGoUReUD+jXoHpJytog8tTSi0n7vew
 BvXbZgEQzjToOIcOJBHZJJUPGMw/o39lTH9K2VPSciVaAd0O2cvMow8apnH6bJVMWHBIhE5mK
 8VUAZNeiFBRieoxwPz4hq//9/gWc7Kr4QEAWbt0TiFelGmbhTmYF9KKQqm5FdSVxcoGoT8Tjs
 mHnTYhnK87H3iHSDpJMSWSD+56NezF8b6Y81CccIwdehOgpGn5FaKNyFz31YTIk0zsUsXXDoR
 FXETnGpRb1fpBe2k8B1mqzeH2n+0OnrIf7VKYZ6p1ezMrZbFsvdc/rS3rGSa6HBKQJOIBw7f3
 9ZbZT82GYD94H9YQXYlhvA0DVQigMHUCzsJ8YIeUcXJr9Fh4yfBL/plOF01wuOzwdPSKVIU5v
 uxMbccrn+SX+SlaabuZ+idJlKqVGjuElp7ILYvSdzYVaMlrybNEfJG10nm4O5qmgtU+AOs9N/
 ohdGyVowKw34FnxcfqLrM9ZJ04iyMjhyWTzBut86PBZQeVcgzzkjnHxkB5R0hB1SFj6KnaFQb
 wkIiFGBhYUGYAK6sS3JIBH6HuJF278MQe5RvaH5l7ZHHRuJr1ynEn3uVEgLHSh8jLJPEN5SmH
 Ye7WbJI6HlgrTjGfkD+aZRVJjuDyMFR87AF8Z7kVjwklG73K81Da1Yb36LNOYOSAmJzDspwsF
 wbndTegsozmjslDdSAJoYnQ6MPkP8r/pBP32rIqU8wTFnEsfAZlgdj5v4zEMTmhlI7rKlJl7Z
 hinaTfZlAQ59sVvRy10sYnNaX/7Yl/1BDPP178LGDqFjkN8MItz74HVvxAzxztjydvVkUd5Jq
 Zei+7SWC4qmtdy4br+xd4iKk7qKc7pFF+8mxSuUtMAxN3r7x0sussz6rOFmZ+MTAYFXTMVrQ+
 cb2qqrkL9GocfT3HbbyW7ZVu1eGXNmtOyh14kt5BGm6j9+kZci/j2Chx4rYdSU9bYhtclcXNW
 6OMLQgFcM9bSwAfJt2Kz60rok1KZzqgbsO66c03e+iaRHEi6199u7YW6zTQXNFFIXdMbiB0VK
 HcO4tobDwrT9PxCnY2WOLg2K00CFjEFG2l4V12cTuegwjq4MxXHZRTI6nxCDN4MPbYNogLP9+
 YNLolchmtHBnTSisH5/QlsKsdjBty++d2bZsyyrgyOD6x6qD87z/Dm6MHqQgjHsO/Jia6ASzd
 DYd5dHY1gkvqrT7TPz8z67yfaPBZ0QTJzalMf2jzu11oeagRzpalo9bJDYZoFd4PnNOycBAu4
 oB8VltM94X1B0PsGGP2agM1S/0I6M5EKvEJojdwJgVyfyEerD3a27vcQ/Bo5SfyN4+32W9TLZ
 J5lMiWSyqzvItk7JXLQv3UMArE6VaPb/0k2nk59AjGTH+1RiUeTTrxREtrgrzBAEwDThEkUZ7
 8EVet5RjDTvz5baRF1zPbwm6GP1dcUcmBNLN8SfCnQ6zU4bXRgxmF95KyUD8PT6oB77FxG9y+
 yjeiem4zfrM/f2Roj0wDU51OMvNmS51wZhcwdVplovfXWQb+41K035SFrcVNyVn5qqtdoL2uj
 2qjG0mdWJIKJv9iPUgHz4iFFmO00CwMfS/pqoLh/0urDNgq7OoPjDYgyZf3FYKzeo53OeLBy/
 QPckKBLqmP0ax1M/KM5KyakhpSY3V0YqXBM8f6sjLw9LQplSqPVXfNSl02zeMImQb1pOky8AR
 heTdTn2NOFDohoR8nqvYVu+WDkud5Ub13oC+QyWdO2kgpZaUmgbBnrJQF+f5qPcC577AI4G/S
 3WBpGdBIA+20K7GDusJdG5fGoBZfhemtRCt115hM8VcFzjvbcOh4hXW63jRRheGo9Wt04uoG+
 Emk5LGuxk1hKEjjXykmlNjuc04+pGyb0tlZIzOGdag3kWX8U1zMPkiGD1JzyAEIk/4mZLKaJn
 bsPZl8Dt2zzPxBft9O3kVGuI/guDER8Lh4LDRbfU6hWg31Q3jTs9FY+MDptxqecn557lxsZLk
 sGiB85msrS0wHHmfOEYq+Edq9q/lbkBQpWX9uNGddna10NE5LLRIk1X5pzVmydnQQShxyFslk
 rqXtK0ngynuLR4JG3p79/QjVTv9oAhRsQgg8JTOFx+Nz0bRyRXgusKeXridzWBXW24kcsRrF+
 XzqIzoAR0qcbfLV+itJTxOeMQoU8wfnf+SV6jxYealzBJYtfTY+4r4U9jHxB60hJ/uAqh/5YT
 v3kxwEFb1qRCopdGE4yOb4MFt2x7KaB53fb7D5vn2F3XZyUNQqT+TgHE7oiXfopyXjLznJMfn
 cLFFtcA1cweWjcvy729sbEuX65IgLNfRMBb/6HnvPaP5hilIrulQ68gMmXZ9hkMoAYHeKY+9n
 9trodeivI+ihELo2OLf1MPvghbKU/u1RvSMrYlrDf7ukmRYkyVZymlUmqK3LwgyVhFo7vaORP
 HBubcqC5TOw==
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

On 27.06.25 12:02, Peter Robinson wrote:
> On Fri, 27 Jun 2025 at 10:45, Michal Simek <michal.simek@amd.com> wrote:
>>
>> Add option to disable help command in size constrained systems to save =
some
>> space.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
>=20
>> ---
>>
>>   cmd/Kconfig  | 6 ++++++
>>   cmd/Makefile | 2 +-
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index f21d27cb27f2..3f4221cb4d02 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -189,6 +189,12 @@ config CMD_FWU_METADATA
>>          help
>>            Command to read the metadata and dump it's contents
>>
>> +config CMD_HELP
>> +       bool "help"
>> +       default y
>=20
> Maybe "default y if CMDLINE" as it also doesn't make sense if there's
> no cmdline enabled.

This config is enclosed in an if for CMDLINE.

Best regards

Heinrich

>=20
>> +       help
>> +         Command to show help information about other commands.
>> +
>>   config CMD_HISTORY
>>          bool "history"
>>          depends on CMDLINE_EDITING
>> diff --git a/cmd/Makefile b/cmd/Makefile
>> index 80cf70b7fe8c..718eff4ed197 100644
>> --- a/cmd/Makefile
>> +++ b/cmd/Makefile
>> @@ -7,7 +7,7 @@ ifndef CONFIG_XPL_BUILD
>>   # core command
>>   obj-y +=3D boot.o
>>   obj-$(CONFIG_CMD_BOOTM) +=3D bootm.o
>> -obj-y +=3D help.o
>> +obj-$(CONFIG_CMD_HELP) +=3D help.o
>>   obj-y +=3D panic.o
>>   obj-y +=3D version.o
>>
>> --
>> 2.43.0
>>
>> base-commit: 8c20ef07b8939e5ea703224ad91a8669badaaae5

