Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C8DC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 16:59:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A95CF60873;
	Thu, 20 Aug 2026 16:59:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V4xXrbUCKZpq; Thu, 20 Aug 2026 16:59:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787245186;
	bh=2bHVPd5hVBSc6rsTNKGiUcsfuwbC8IoDnRItX4xt3Tw=;
	h=To:Cc:From:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BY17uWLUUldvCz4/O/lbi5cLyzRAqs/GA41/ZQ3ITIjjeL4Etuo5p95wKEyLo5mFB
	 +muix5S/6sGz4p+DkaYgOvPnPqarGCPvZVsX8khqtGdGjeaf1AXWpVob7fERiwQjLx
	 UmVoTjRs6l7JMScBX7469xqMoSpGhHDzxCamOp2QIvtRkMjOpR3QiiTKeDbluqByFb
	 m6hB0S3uyM29l2Iq2RGka0Gx0yZxZ+TfPTAktSH/0ETKjpYxzWD/EMa0FLdBDKBmTu
	 tjJybpEbYCmZuRsoY/yV3DTJdwWS9S2OY6UYUModTySA8TlgnP7+Zoz8KirFNh7vAh
	 pAhyLoXbWu2JA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA0DA60862;
	Thu, 20 Aug 2026 16:59:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D53BC198
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 16:59:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C76D860862
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 16:59:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xi9DmdoXoEjm for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 16:59:45 +0000 (UTC)
X-Greylist: delayed 1890 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 20 Aug 2026 16:59:45 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=icloud.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com
 header.a=rsa-sha256 header.s=1a1hai header.b=v+vjXDgG
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3001:201::39; helo=outbound.st.icloud.com;
 envelope-from=valentinliu@icloud.com; receiver=<UNKNOWN> 
Received: from outbound.st.icloud.com (st-2004f-snip6-6.eps.apple.com
 [IPv6:2a01:b747:3001:201::39])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 082646084A
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 16:59:44 +0000 (UTC)
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPS id
 C82B9180034E; Thu, 20 Aug 2026 16:52:04 +0000 (UTC)
X-ICL-RepId: 01a02016-4238-7692-af7b-96060ad2cac4
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ9IHV8FWhxEC1YCXwBLVxQEDlIBUgVGGVcUWhh3AlEcVg1XQ1QEX1BfHA4EVAddBV1WUAJaS0ATBEATBVIHXU1WDUcPWB5cFBcLR0NeCF4fTBwdDlgGEgBNCg42BlkFXglWA0MFNhIUXUVaDlsERxQXG1wAFwZbFAREAl0GWAJJAUAeDA5aCl0NQQVVGgkAFA9VUVlVXwRACRwBCw9ech1cVlACWlUSBEAIVlBeCF4fTBw=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1787244725; x=1789836725; bh=2bHVPd5hVBSc6rsTNKGiUcsfuwbC8IoDnRItX4xt3Tw=;
 h=To:From:Subject:Date:Message-id:Content-Type:MIME-Version:x-icloud-hme;
 b=v+vjXDgG1hNVhqYOdjnTs6gsv6RRBSu/3nyZQN1h68oYABYD2eEigY5rkRh4ZN9KQ0xnnlkaYaSgi8Yz+EA9qB7CBM5+aMTnlTESWPJBM6Y5wfTWCJ++tsJwDHH0yMYCXqsG5XpYOlLiTMB64pn5450VHArTjBxfvyRiCKRefEkcgqWdq8WDTEmUN9arTxBLq9lQSXdXEU6SKSn4zaJQthqohRZci4V+WrFwq/6UlabK6bnVAH/Souv9wB+2tT2rVP4qnxty1qHzC1e6mzYKOa3p/4PYpvr8XxSXcaRo/7QKljKnHsQ4VZ91QE/VlEBofWmNew2lVbaiaRG43CKlUg==
Received: from p00-mailws2-7c9f864df-fgrww (unknown [100.81.28.79])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPSA id
 6AC181800366; Thu, 20 Aug 2026 16:52:04 +0000 (UTC)
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Johan Jonker <jbx6244@gmail.com>, u-boot@lists.u-boot-project.org
From: =?utf-8?B?5YiY5Z6j6L6w?= <valentinliu@icloud.com>
Subject: =?utf-8?B?UmXvvJpSZTogW1BBVENIIHY0XSBhcm06IHJvY2tjaGlwOiBzcGw6IEFkZCBo?=
 =?utf-8?B?b3RrZXkgZGV0ZWN0aW9uIHN1cHBvcnQu?=
Date: Thu, 20 Aug 2026 16:52:04 +0000 (GMT)
X-Mailer: iCloud MailClient2630Hotfix39 MailServer2612B5.952a5ad53a12
Message-id: <10130988-a918-4968-b2d6-b4b4600d2f85@me.com>
Content-Type: multipart/alternative;
 boundary=Apple-Webmail-42--475b7d11-006d-4098-b095-6fb06b5a5041
MIME-Version: 1.0
In-Reply-To: <5328ff1c-2b50-42e2-9137-9e5f6720c345@kwiboo.se>
References: <20260818165526.764686-1-valentinliu@icloud.com>
 <20260820162757.665777-1-valentinliu@icloud.com>
 <5328ff1c-2b50-42e2-9137-9e5f6720c345@kwiboo.se>
X-Proofpoint-ORIG-GUID: Sj1YfmT0bNxkQGp1VTBuoThDTAmEoqTV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEyNyBTYWx0ZWRfXxgha2NSo7Zre
 d093/fSOD3fpzF+j7fx8SduIj5edJbHsUI1Tdrv8GMJOscYsV6HBW4kcUA34ctpRsQf2LXXHKD3
 KwSpFB+RUWy5yGgOgYWYwvlFRwMjAY67Oaf1DxMV0OY4kJnY4v8l910GJivCO5fClXQWSKtsAKC
 Qov2hqlQPWWwWQHmCMqvJ4SXE/dXroPCKoax/4WYW07+SNc48DhNpxRx4qBKuV8Sl8otgpTgKKK
 rcv8/eCmRKxD2+U6RJEutsZ4sliGTChu4PzlljQka/gSNpBMty3b+Omges12wlWiS1RR3lvOW21
 J4lUuUsh3dWs1reXLn0nAZ1MuE1jX+b4Szosj7jjA4sIH4es/HhOgxKgw0hZGE=
X-Proofpoint-GUID: Sj1YfmT0bNxkQGp1VTBuoThDTAmEoqTV
X-Authority-Info-Out: v=2.4 cv=R5sO2NRX c=1 sm=1 tr=0 ts=6a8730b5
 cx=c_apl:c_pps:t_out a=cJP21P0HhicdWZYbiZjVcQ==:117 a=Sv0fKeRqtYgA:10
 a=5KLPUuaC_9wA:10 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LQAHsTbMm04A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8 a=oMmUOC4ZUUfs2ovSru4A:9
 a=QEXdDO2ut3YA:10 a=jLASUpfQMj937jA-K5cA:9 a=kOSnd_fXylgF2MI-:21
 a=_W_S_7VecoQA:10
X-JNJ: AAAAAAABRrFFWoLV3HyWr4eYj1e8xPOXUwyxWr9EYN1AOgIqSoOpZhluWwlrpfRtB9vJQQ22wX2uiGeYfM/d0biwCYwnjOLtZZFkfV9/oZOETXmEe/k0KgS+TZShqdkBzNxawVaLCveXd3FfwTOsmcNeS5ScgBujlu52O46ifY2Yk9B/DpAWEV+BzWygvNtgr4n+gx77NzdHVm/Z2q3knL/Wa88lcLodVfaNZqCS6a1XLR7NnRFulgd0iQHqj/bPCujKKJveFy+I7XZsMAVTsQuK7PLKJXb1s2hfe1lDRBByy5yr5eCi6OMTnGPuWDcNrxHO2q+/2MhrpUX28iFkkCHrCMrvfhq9I1bNbc0WXMG/1WwCbiNRkOXtE7Kh0kbHQJTg9qJiF7+RqBpuKTP/AThaaR3ogs284er5oKCCIWE23lsDLaX3Ih2mmGElj4vEWNwpZZnbEAcruDd/2KAO7skB08cIcSGKw/fyf6r9F2KqwxCLD8e00+3q++6sbU1jtqQwFSdhtlUWZrDR/38APvozkFSxshC/IyiEPhQ8bmFHU0YyfRfkrP6jVg5KPVgOTYY3e1vrEJNcapReEcNM5yJwiS1plyF27blP5A4ZD0WnZpXyr8qnxXWjpTpNLuvcTd/ZDrB/gZ+uNZ4Ld9V7PxUUCkqp2ej4I8fK4NlcWLDDHxjV7dk7JPYsBL+QnMCFbTV4+7rsuqZPcLweqokHosTjDkQMAMmVQZBCYiJJ2ZUhvHJQ8ymKdafH+tK8K1uCk7eFJr94Wldlp5N2TopKNWtlqxzxpTFycTDP34EvVf9dETs71VqEzM3geTH0M0Lyx1VNhSUPIYOK62/SSfXblD96PLBrya4XXBTgXwXef1uZ9pA0yarESrNUzY8Qv0ovEkEaF6OEmV7oEeNsdEjOjda1XwqxIkQDWxG2yGh3TYXb3nOsbXmxll+Glplhb8/miFI+w/jAp3XMIqdC4WTusw9C4AUG/K6
 9if3r1yJvLmgCW0L33CdPXKlPiduXQgj0a9ZijH0ebozAZ4mDIJ1HiMqHlzjXOpQsigI307xIu6Vvhoq1BArDLiCXB4pKaZLa7AM/0DbWN0jgDWJlLaCFEXfy6ZgvDqZTLyiNoq7/ebFkGa4Krqc52OioeV7oeM67WlscHqOEH1qD3XF4HxegLCs+j7qGDNoRupj4D2wccbXQQnrwlo2c8sTkQcU4UtSsVo4vlHimPrUbWcnEBn59AQ2u5d3d48Navczp/0O2lfvUUCMmHU1MTu1Ifxthg2yB+IC6W+VDR+PfG5C2rJsxIJvtVhtJ0f6kdOj/V2XRz+xydVeQLTqM30y/3KJUAWn+gyvbZgUk464fveX7V0pnRH9OoqGBKyZkDvw2iF3vAS7jMqP85lxa7jVEKVKd7sd8BBbEUGnYcB1ydS8hoafPPg/TjDG9wUce3R/uTzGB0IuC9Q==
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


--Apple-Webmail-42--475b7d11-006d-4098-b095-6fb06b5a5041
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
    charset=utf-8;
    format=flowed

Hi Jonas, I really consider your idea before writing this patch, however, =
this patch is a standalone function. The Rockchip U-Boot branch has the sa=
me function If you want to use "reset" command to reboot into MaskROM or a=
ny other mode, you must be able to enter the U-Boot (not SPL) or higher le=
vel OS. But sometime, we will unable to enter them (Like booting failure o=
n out our control of firmware), we just need to rely on the physical butto=
ns to hard (or cold) reset device. But if we haven't the physical button, =
there will be harder. Absolutely, we also can't rely the fallback of firmw=
ares, so the SPL hotkey can control what mode we want to enter in SPL stag=
e. I also like the unified "reset," but that is unrelated to the functiona=
lity provided by this patch. Best regards, Valentin Liu 2026=E5=B9=B48=E6=9C=
=8821=E6=97=A5=E4=B8=8A=E5=8D=8812:36=EF=BC=8CJonas Karlman <jonas@kwiboo.=
se> =E5=86=99=E9=81=93=EF=BC=9A Hi Valentin, On 8/20/2026 6:27 PM, Valenti=
n Liu wrote: Add a configurable Rockchip SPL hotkey feature that checks th=
e serial console during SPL startup. Ctrl+B can be used to enter MaskROM m=
ode and be widely used. Ctrl+D can be used to enter Loader mode, Ctrl+F fo=
r Fastboot mode. We can add more boot mode support in future. Why the need=
 to have special hotkey handling in SPL? I would rather see that we extend=
 TPL/SPL/proper with support for reading any 'syscon-reboot-mode' reg and =
act according to that. Also think there is a series on list to extend the =
reset command to accept a reboot-mode. That way we would be able to reboot=
 from OS or U-Boot proper into maskrom (or any other) mode, instead of try=
ing to implement platform specific hotkey handling. Regards, Jonas Add CON=
FIG_SPL_ROCKCHIP_HOTKEY to enable the feature and wait for the serial port=
 to be ready to receive input before checking for hotkeys. Signed-off-by: =
Valentin Liu <valentinliu@icloud.com> --- Changes for v2: - Simplify the d=
ependencies of SPL_ROCKCHIP_HOTKEY. - Remove the conditions for the newly =
added includes. --- Changes for v3: - Add a dummy spl_hotkey_init() to avo=
id undefined reference errors when building without CONFIG_SPL_ROCKCHIP_HO=
TKEY. --- Changes for v4: - Add condition of CONFIG_ROCKCHIP_BOOT_MODE_REG=
 !=3D 0 to prevent SPL hotkey be compiled and used on unsupported platform=
s. - Add more hotkey support (Ctrl+D and Ctrl+F). - Remove prints on the s=
tandard path. - Add some code comment. arch/arm/mach-rockchip/Kconfig | 14=
 +++++++++ arch/arm/mach-rockchip/spl.c | 54 +++++++++++++++++++++++++++++=
+++++ 2 files changed, 68 insertions(+) [snip]
--Apple-Webmail-42--475b7d11-006d-4098-b095-6fb06b5a5041
Content-Type: multipart/related;
    type="text/html";
    boundary=Apple-Webmail-86--475b7d11-006d-4098-b095-6fb06b5a5041


--Apple-Webmail-86--475b7d11-006d-4098-b095-6fb06b5a5041
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
    charset=utf-8;

<html><body><div><div>Hi Jonas,</div><div style=3D"font-family: &quot;SF Pro Text&quot=
;, system-ui, sans-serif;"><br></div><div style=3D"font-family: &quot;SF P=
ro Text&quot;, system-ui, sans-serif;">I really consider your idea before =
writing this patch, however, this patch is a standalone function. The&nbsp=
;Rockchip U-Boot branch has the same function</div><div style=3D"font-fami=
ly: &quot;SF Pro Text&quot;, system-ui, sans-serif;"><br></div><div style=3D=
"font-family: &quot;SF Pro Text&quot;, system-ui, sans-serif;">If you want=
 to use "reset" command to reboot into MaskROM or any other mode, you must=
 be able to enter the U-Boot (not SPL) or higher level OS. But sometime, w=
e will unable to enter them (Like booting failure on out our control of fi=
rmware), we just need to rely on the physical buttons to hard (or cold) re=
set device. But if we haven't the physical button, there will be harder.</=
div><div style=3D"font-family: &quot;SF Pro Text&quot;, system-ui, sans-se=
rif;"><br></div><div style=3D"font-family: &quot;SF Pro Text&quot;, system=
-ui, sans-serif;">Absolutely, we also can't rely the fallback of firmwares=
, so the SPL hotkey can control what mode we want to enter in SPL stage.</=
div><div style=3D"font-family: &quot;SF Pro Text&quot;, system-ui, sans-se=
rif;"><br></div><div style=3D"font-family: &quot;SF Pro Text&quot;, system=
-ui, sans-serif;">I also like the unified "reset," but that is unrelated t=
o the functionality provided by this patch.</div><div style=3D"font-family=
: &quot;SF Pro Text&quot;, system-ui, sans-serif;"><br></div><div style=3D=
"font-family: &quot;SF Pro Text&quot;, system-ui, sans-serif;">Best regard=
s,</div><div style=3D"font-family: &quot;SF Pro Text&quot;, system-ui, san=
s-serif;">Valentin Liu</div><div><br></div><blockquote type=3D"cite"><div>=
2026=E5=B9=B48=E6=9C=8821=E6=97=A5=E4=B8=8A=E5=8D=8812:36=EF=BC=8CJonas Ka=
rlman &lt;jonas@kwiboo.se&gt; =E5=86=99=E9=81=93=EF=BC=9A</div><div><br></=
div><div><br></div><div><div><div>Hi Valentin,</div><div><br></div><div>On=
 8/20/2026 6:27 PM, Valentin Liu wrote:</div><blockquote type=3D"cite"><di=
v>Add a configurable Rockchip SPL hotkey feature that checks the</div><div=
>serial console during SPL startup.</div><div><br></div><div>Ctrl+B can be=
 used to enter MaskROM mode and be widely used.</div><div>Ctrl+D can be us=
ed to enter Loader mode, Ctrl+F for Fastboot mode.</div><div>We can add mo=
re boot mode support in future.</div></blockquote><div><br></div><div>Why =
the need to have special hotkey handling in SPL?</div><div><br></div><div>=
I would rather see that we extend TPL/SPL/proper with support for</div><di=
v>reading any 'syscon-reboot-mode' reg and act according to that.</div><di=
v><br></div><div>Also think there is a series on list to extend the reset =
command to</div><div>accept a reboot-mode.</div><div><br></div><div>That w=
ay we would be able to reboot from OS or U-Boot proper into</div><div>mask=
rom (or any other) mode, instead of trying to implement platform</div><div=
>specific hotkey handling.</div><div><br></div><div>Regards,</div><div>Jon=
as</div><div><br></div><blockquote type=3D"cite"><div><br></div><div>Add C=
ONFIG_SPL_ROCKCHIP_HOTKEY to enable the feature and wait for</div><div>the=
 serial port to be ready to receive input before checking for</div><div>ho=
tkeys.</div><div><br></div><div>Signed-off-by: Valentin Liu &lt;valentinli=
u@icloud.com&gt;</div><div>---</div><div>Changes for v2:</div><div>- Simpl=
ify the dependencies of SPL_ROCKCHIP_HOTKEY.</div><div>- Remove the condit=
ions for the newly added includes.</div><div>---</div><div>Changes for v3:=
</div><div>- Add a dummy spl_hotkey_init() to avoid undefined reference er=
rors</div><div> when building without CONFIG_SPL_ROCKCHIP_HOTKEY.</div><di=
v>---</div><div>Changes for v4:</div><div>- Add condition of CONFIG_ROCKCH=
IP_BOOT_MODE_REG !=3D 0 to prevent</div><div> SPL hotkey be compiled and u=
sed on unsupported platforms.</div><div>- Add more hotkey support (Ctrl+D =
and Ctrl+F).</div><div>- Remove prints on the standard path.</div><div>- A=
dd some code comment.</div><div><br></div><div> arch/arm/mach-rockchip/Kco=
nfig | 14 +++++++++</div><div> arch/arm/mach-rockchip/spl.c   | 54 +++++++=
+++++++++++++++++++++++++++</div><div> 2 files changed, 68 insertions(+)</=
div></blockquote><div><br></div><div>[snip]</div></div></div></blockquote>=
<div><br></div></div><div><br></div></body></html>
--Apple-Webmail-86--475b7d11-006d-4098-b095-6fb06b5a5041--

--Apple-Webmail-42--475b7d11-006d-4098-b095-6fb06b5a5041--

