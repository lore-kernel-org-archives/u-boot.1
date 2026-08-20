Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E73DC5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 18:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45F1D80F34;
	Thu, 20 Aug 2026 18:39:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J9SUHp9OOxCp; Thu, 20 Aug 2026 18:39:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787251142;
	bh=GkprgWwisnhzg5dWavnfkHC18V2qdhj9qF8+Qi0qPpo=;
	h=From:Subject:Date:References:Cc:In-Reply-To:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cw1SxdBftUjOEo1G1bz2jqQmBxh1c3rQ0nYZ93nsv0RLNU48w6biS/velDWhUu4A2
	 kHIVVLfYfkWduVlQDcACx1UVlAe3orcDYzdbzkWFPFa+JYHHa858uWL5R0ntibAqF4
	 Vm2gKy1SvUa5MseQW5aKiUgPKKjL5B8NFN8yzoalnvqrzXC85O3MkazKVpDkj2QM5b
	 8atuVd/E9ybQGP3zxvR97A5YbqszS4RUEOQR1BFz67BTofaoMkduGVgxsCon/wcWnE
	 4Mqs6gms8mbuKCsuApjRPBQMzqAf4u+z4bG0LTazTqJ3fi7O/rvUa80dnh9jKP/PAr
	 f4AVsji7VT8Mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B80180F26;
	Thu, 20 Aug 2026 18:39:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A649EEA3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D9DF80F26
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:39:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ioBQz7CvyZOg for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 18:38:59 +0000 (UTC)
X-Greylist: delayed 417 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 20 Aug 2026 18:38:59 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=icloud.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256
 header.s=1a1hai header.b=sYH4jcQp
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3003:201::68; helo=outbound.pv.icloud.com;
 envelope-from=valentinliu@icloud.com; receiver=<UNKNOWN> 
Received: from outbound.pv.icloud.com (pv-2002k-snip6-1.eps.apple.com
 [IPv6:2a01:b747:3003:201::68])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7DC9680F1A
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:38:59 +0000 (UTC)
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-2 (Postfix) with ESMTPS id
 8FD021800F2B; Thu, 20 Aug 2026 18:31:58 +0000 (UTC)
X-ICL-RepId: 01a02071-b735-73df-b0c1-c3441929f98d
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1NHVwDXhxHC1YCWAJLVxQEDlIBUgVGGVcUWhh3AlEcVg1XQ1QEX1BfHA4EVAddBV1WUAJaS0ATBEATBVIHXU1WDUcPWB5cFBcIRUNeCF4fTBwdDlgGEgBNCg42BlkFXglWA0MFNhIUXUVaDlsERxQXG1wAFwZbFAREdl0CXnRFCkAeWQ4uB10NPQsvGilzQA1VBFQGLgsyC0sCWQ8qchlaFFwYU0VRH1RGExlOG1dNUBtfAkIP
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1787250720; x=1789842720; bh=GkprgWwisnhzg5dWavnfkHC18V2qdhj9qF8+Qi0qPpo=;
 h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To:x-icloud-hme;
 b=sYH4jcQpI3aPH95wgJzDUc2BN3qCUVt3/6NOaKRTsJhY8nkK5JDPIrl71xpSjNa6QWQx2s+Z/Dx5mhD5i2UQrO19ubiOZOsar7QkH29pxYAJLuPoGeyzraIROV+ouVUmd7EN0btioQciWA8Q6rvLe6EYWxBnRc1KJ4FRd1N59iODWDCV6Jq5fIOj8xchoErbqDjpclFr8FYFgFDxHaqV2lS3h1ZzFcFWgqqEoJV4HcH8AUBg/rMRYRNk2qkuTl/74ffgzkUWZGQnJMg1g4k2bwaGyBUT8QbCzzfhZ0auQ0+VE5Rp5zKVoqJ2XCoFhot6usH5SZR/rWtcsa7fk4MOvw==
Received: from smtpclient.apple (unknown [17.156.192.29])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-2 (Postfix) with ESMTPSA id
 BDF50180060F; Thu, 20 Aug 2026 18:31:57 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: =?utf-8?B?5YiY5Z6j6L6w?= <valentinliu@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] arm: rockchip: spl: Add hotkey detection support.
Date: Fri, 21 Aug 2026 02:31:43 +0800
Message-Id: <E055F538-49E5-4E8B-BA04-791E9B23148A@icloud.com>
References: <e172b074-798a-4b29-b080-0e2f8eb28d29@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Yang Kever <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Johan Jonker <jbx6244@gmail.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <e172b074-798a-4b29-b080-0e2f8eb28d29@kwiboo.se>
To: Jonas Karlman <jonas@kwiboo.se>
X-Mailer: iPhone Mail (24A5380h)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEzOSBTYWx0ZWRfXybNgRfWoaIAT
 JvBJAUpw/ETfZG3uuoY9xgkBvsBKp+O0NIn7xgssftQe4D3Pr69wm7c82jQd3ZrCuwK1luLAfFx
 6tQHhypmPHGbFh8vnd972Ds5rNkbabbE1n1tnlPlKugwbRYAAbS/lZ0K5SkbjqHxWkuQsxoCD4e
 dwdBSgrwcgKOLXUkwORYL1HXvKNHf2/w5fjabwzL1N145oO0AvE05y9XFXZinDNxPW1oStAuwoR
 reFfU3yDYtoc56kHZ4u0FesqGbIw0FvZBTZL3SYXufjjmW9ohWFkasrncXVI+jOq9ppHt9IVR9p
 P4CIUj3eZaRj61K9wD+FMrzD5Hmt0zMYQtNC/QIF3heTpbGLlu7ZL09s632Xvs=
X-Authority-Info-Out: v=2.4 cv=HPXO14tv c=1 sm=1 tr=0 ts=6a87481f
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LQAHsTbMm04A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bC-a23v3AAAA:8 a=v3ZZPjhaAAAA:8
 a=Yqbamb_6UqI-EgArOUcA:9 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=jlmeD0N1rMegYWW813pM:22
X-Proofpoint-GUID: y_qvyJfXV5e52_53fFpRbRWbFq30mNXs
X-Proofpoint-ORIG-GUID: y_qvyJfXV5e52_53fFpRbRWbFq30mNXs
X-JNJ: AAAAAAABWcUaHbQUsWdbZIZxMI6fi0s921HlXCaYXrj3dN9cLqIx94AgUNzZu/un96oR6WxEFuVl5znmxadYzwcSQ0oTCrOqL8MIGcKZAWvb2fytnLGZPJAZwpiI1Pbl10CBy40Dsw/sxGrXGO2D4j48/HTp3XkiTkUKAPHp5vQgXlIjd8Gp6+34FZK3BcMdzS1S8DXwv2i5Oa8CRAhUohep8DSFUgMUUlYI24Fvr7elQvrSHq9K8a9mxU5YLG+/X4ukEhXsraMQZsuU+o7DoD3nJ4UqIxxAxH17pmagbbVKUjLLnb6RTXDTjIh3swITe7omMy4uD1zzShH96IXv0y8rj9BygbhW8DKrP4aBBSgoLrQM2Xj3lzvmAiCd9iWA+XQJE9O9su2kWkfHxu583YHh//cyk9ufFa5zh91/MtqEO86fghxBz75lPIx2OkqwO+hD4VNpgxhWOfxdXqY0gmZ8D1ZnU/Hm4tu46LD2wLkPxAE3ldFhuKMfC/JyJd8obt03EEATslN5aW9jR1nU6iNQ7CWcmlr4GcnAIHFwX9kCqIXtnyXMR1pR1MnS30TMVtaW1NhB2iASeHtRIDFknJHEy7w30DkfuYN4beb8xDgxAtvZUdWdg7tR2mcEmsz7N0NVky4zmCp2BJIBnnHvj3XSWzDPiQDn6fqUbEo6w+46Qk4VcEud5kNSA8RakuPgVsCBSg7D1WgQcB4BUPf+Vx4qFJJsI384rb91ITk46tEeV+UHiAfIccFoXfmbyPoTw7iikn7cYlxlfXyBomATWPXmnaGrcNCKXXiYyXF9oa/+FXIvroPgqaQV2ID5lpSlfer8SccfDDrrbiPA5ypgpw4rybbJ6Z8OvWiTDYdWITPCMMqIew/yz1iYBEy0DSWukK/fEs2rjreu0OvknJq80Sof0jJOpdSYvmHkRWMCPo9rgqUoLTZg7RU9MoKZtMG9luQAeC+egLxk1wFKx/s9OvJdlZJ9xUt
 PEumCaTOi5NQMWNyot7RnpHu3riJXei9KOaNOuEWkwEZ7PXQyEhHKmamduvAWYIyaMxEW2fZrpw8syRwTG1yVQCNk99rvyABDc80k0aXCrlDUrdVfrUTy5aSb6PCNqRjEWLXfc/1h+4f3LS9Cq2OroAjgIJ/Kt88IOssmBAHUB5r5Qw/AuLV1a5/ZO19qIfaKGskLb7+AHf290L+gqVrgh3oMY3MUZV1KoUPzQQK+VnViz7hROBkYmRaeyN9lKyS//o7bZbfD2fVAP2/aVNChe2TLBaosbyKen0p1esLCVfK1r+b1ufIxS0xWosNkOwQh8KwkHJhZnZqaczWzpmcTB9oMwP5yaEbE1gI4QLSwM+vB2sD7qVc4NBpSw97+FIuluQudRpPArw==
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Jonas,

I am not suggesting that this feature should be added to the mainline simply=
 because Rockchip's U-Boot includes it.

Even if the firmware is loaded after verification (via hash comparison), tha=
t only confirms it hasn't suffered accidental corruption; if the firmware it=
self is flawed=E2=80=94such as issues arising during ATF/OP-TEE development=E2=
=80=94 the boot process might stall before reaching U-Boot, and it also unab=
le to trigger an automatic reset (even though the SPL successfully loaded th=
e payload). Therefore, the SPL hotkey function is not intended to handle SPL=
 firmware loading failures; rather, it provides a way to enter modes like Ma=
skROM without relying on physical buttons. It is an optional feature.

As for watchdog-based status monitoring and automatic resetting, I haven't d=
elved deeply into the watchdog mechanism, but I think this would be a separa=
te, independent feature.

Additionally, we should consider adding SPL support for Loader mode and Fast=
boot mode in the future.

Best regards,
Valentin Liu=20

>=20
> =E5=9C=A8 2026=E5=B9=B48=E6=9C=8821=E6=97=A5=EF=BC=8C=E5=87=8C=E6=99=A81:4=
6=EF=BC=8CJonas Karlman <jonas@kwiboo.se> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> =EF=BB=BFOn 8/20/2026 6:52 PM, =E5=88=98=E5=9E=A3=E8=BE=B0 wrote:
>> Hi Jonas,
>>=20
>> I really consider your idea before writing this patch, however, this patc=
h is a standalone function. The Rockchip U-Boot branch has the same function=

>=20
> Vendor U-Boot having a feature is not always a good reason for including
> it in mainline.
>=20
>>=20
>> If you want to use "reset" command to reboot into MaskROM or any other mo=
de, you must be able to enter the U-Boot (not SPL) or higher level OS. But s=
ometime, we will unable to enter them (Like booting failure on out our contr=
ol of firmware), we just need to rely on the physical buttons to hard (or co=
ld) reset device. But if we haven't the physical button, there will be harde=
r.
>=20
> In case SPL fails to load the payload we could implement some kind of
> hang() fallback to BROM [1].
>=20
> We probably would want to use a watchdog to truly recover from the event
> that next stage crashes/fails/hangs. Possible something like write value
> to boot-mode, start watchdog, try to load payload, re-arm watchdog in
> U-Boot proper and clear out boot-mode.
>=20
> Btw, there is nothing that acts on BOOT_LOADER and BOOT_FASTMODE is only
> handled in U-Boot proper, so those are not really useful in SPL.
>=20
> Some SoCs also clears out the boot-mode reg during reset, see [1].
>=20
> [1] https://patch.msgid.link/20240202001221.531207-1-jonas@kwiboo.se/
>=20
>>=20
>> Absolutely, we also can't rely the fallback of firmwares, so the SPL hotk=
ey can control what mode we want to enter in SPL stage.
>=20
> Are you having issues with U-Boot proper crashing, or SPL fails to load
> the payload, or it becoming corrupt or similar? What issues are you
> facing that prompts the need for this SPL hotkey feature?
>=20
> Normal boot path for Rockchip is to use a FIT and let SPL checksum
> validate any payload before it gets executed. So as long as working
> firmware is loaded reaching U-Boot proper is typically not an issue.
> And SPL can typically fallback to load payload from a different boot
> media, so recovery into a working U-Boot proper it typically easy.
>=20
> At least those fallback options is something I validate for each SoC
> and/or board that I contribute on.
>=20
> Regards,
> Jonas
>=20
>>=20
>> I also like the unified "reset," but that is unrelated to the functionali=
ty provided by this patch.
>>=20
>> Best regards,
>> Valentin Liu
>>=20
>>> 2026=E5=B9=B48=E6=9C=8821=E6=97=A5=E4=B8=8A=E5=8D=8812:36=EF=BC=8CJonas K=
arlman <jonas@kwiboo.se> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>>=20
>>> Hi Valentin,
>>>=20
>>>> On 8/20/2026 6:27 PM, Valentin Liu wrote:
>>>>> Add a configurable Rockchip SPL hotkey feature that checks the
>>>>> serial console during SPL startup.
>>>>>=20
>>>>> Ctrl+B can be used to enter MaskROM mode and be widely used.
>>>>> Ctrl+D can be used to enter Loader mode, Ctrl+F for Fastboot mode.
>>>>> We can add more boot mode support in future.
>>>=20
>>> Why the need to have special hotkey handling in SPL?
>>>=20
>>> I would rather see that we extend TPL/SPL/proper with support for
>>> reading any 'syscon-reboot-mode' reg and act according to that.
>>>=20
>>> Also think there is a series on list to extend the reset command to
>>> accept a reboot-mode.
>>>=20
>>> That way we would be able to reboot from OS or U-Boot proper into
>>> maskrom (or any other) mode, instead of trying to implement platform
>>> specific hotkey handling.
>>>=20
>>> Regards,
>>> Jonas
>>>=20
>>>>=20
>>>> Add CONFIG_SPL_ROCKCHIP_HOTKEY to enable the feature and wait for
>>>> the serial port to be ready to receive input before checking for
>>>> hotkeys.
>>>>=20
>>>> Signed-off-by: Valentin Liu <valentinliu@icloud.com>
>>>> ---
>>>> Changes for v2:
>>>> - Simplify the dependencies of SPL_ROCKCHIP_HOTKEY.
>>>> - Remove the conditions for the newly added includes.
>>>> ---
>>>> Changes for v3:
>>>> - Add a dummy spl_hotkey_init() to avoid undefined reference errors
>>>> when building without CONFIG_SPL_ROCKCHIP_HOTKEY.
>>>> ---
>>>> Changes for v4:
>>>> - Add condition of CONFIG_ROCKCHIP_BOOT_MODE_REG !=3D 0 to prevent
>>>> SPL hotkey be compiled and used on unsupported platforms.
>>>> - Add more hotkey support (Ctrl+D and Ctrl+F).
>>>> - Remove prints on the standard path.
>>>> - Add some code comment.
>>>>=20
>>>> arch/arm/mach-rockchip/Kconfig | 14 +++++++++
>>>> arch/arm/mach-rockchip/spl.c | 54 ++++++++++++++++++++++++++++++++++
>>>> 2 files changed, 68 insertions(+)
>>>=20
>>> [snip]
>>=20
>>=20
>=20
