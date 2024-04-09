Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015ABC67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 21:15:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 787688758B;
	Tue,  9 Apr 2024 23:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OY+uI92s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E474D87666; Tue,  9 Apr 2024 23:15:02 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7499987572
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 23:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439LEoeF129912;
 Tue, 9 Apr 2024 16:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712697290;
 bh=zfk3+TjNeWpuCXvi99/YGzVewRnvZW5roNkkbD4QoUk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=OY+uI92sabazFP+MpJVzTXYg5bMlCYIjc6GpNhEItaEZa+mqjIi5cunX4/LAGvPat
 yDiGPdZo/tax1qWScoNrau6l+rbkhU2HGAUsK/IhLDsjLuOa9E+MGj7b87TKTs/gku
 edWkV1sH3CGuhirq/QxIxO4rRTy4TJaKi+sEZjJY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439LEokM092520
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Apr 2024 16:14:50 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 16:14:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 16:14:49 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439LEnc9018529;
 Tue, 9 Apr 2024 16:14:49 -0500
Message-ID: <44af30a5-c9c4-47d6-b2e6-7226e01a60ae@ti.com>
Date: Tue, 9 Apr 2024 16:14:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] ti:keys Add EFI signature list
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, Neha Malcom
 Francis <n-francis@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Nikhil M Jain <n-jain1@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh
 Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>
References: <20240408213349.96610-1-j-humphreys@ti.com>
 <20240408213349.96610-2-j-humphreys@ti.com>
 <ee9a13b7-6b52-4bc8-8876-e194e1a66f92@gmx.de>
 <ec241b23-5523-45d6-aa05-5d1667c34773@ti.com>
 <2a818e83-9971-4626-9695-24e7d9c2fdd5@gmx.de>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <2a818e83-9971-4626-9695-24e7d9c2fdd5@gmx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 4/9/24 2:26 PM, Heinrich Schuchardt wrote:
> On 4/9/24 14:14, Andrew Davis wrote:
>> On 4/8/24 10:34 PM, Heinrich Schuchardt wrote:
>>> On 4/8/24 23:33, Jonathan Humphreys wrote:
>>>> EFI signature list using TI dummy keys.
>>>
>>> Adding vendor public keys into the code base to lock down generated
>>> binaries to the vendors unpublished private key does not match well with
>>> the intent of the GNU public license.
>>>
>>
>> The matching private keys are already published in this same
>> repo/directory (arch/arm/mach-k3/keys).
>>
>> Andrew
> 
> Why should we create signed capsules which are already compromised by
> publishing the private key?
> 

If you buy these devices you have two options, you can burn real
keys, or you can burn these dummy keys. If you burn dummy keys
then these images will boot and so will any image you or anyone
else wants to boot on the device. (since the keys are published
anyone can make images for them, that is how we do GP (general
purpose) devices these days)

If you burn your own keys, then you switch out these keys here
and your device will only boot images that you permit by signing
with your keys.

You'll find plenty of open source projects do the same and
give out example keys to show how to use real keys, even
official GNU projects.

https://github.com/gpg/gnupg/tree/master/tests/openpgp/samplekeys

Andrew

> Best regards
> 
> Heinrich
> 
>>
>>> Best regards
>>>
>>> Heinrich
>>>
>>>>
>>>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>>>> ---
>>>>   arch/arm/mach-k3/keys/custMpk.esl | Bin 0 -> 1523 bytes
>>>>   1 file changed, 0 insertions(+), 0 deletions(-)
>>>>   create mode 100644 arch/arm/mach-k3/keys/custMpk.esl
>>>>
>>>> diff --git a/arch/arm/mach-k3/keys/custMpk.esl
>>>> b/arch/arm/mach-k3/keys/custMpk.esl
>>>> new file mode 100644
>>>> index
>>>> 0000000000000000000000000000000000000000..2feb704e0a5fd126410de451d3c0fa4d3edccc52
>>>> GIT binary patch
>>>> literal 1523
>>>> zcmZ1&d0^?2Da*aux2_hA(f&~MnUw(yu0v@E4?-F=u^u*PVqVQ8QZ((-^A*$m*Kg7c
>>>> z&78AJODc2mtxpELY@Awc9&O)w85y}*84Mcd8gd(OvN4CUun9AT2E#ZUJWL@GhWtR)
>>>> zKpA!(HkZVloWx>7bput902hy3NNPo5v4Uq_aY<2WZfaf$h@G5YRFGekSdyAzC~P1I
>>>> zQpnB26;PC)oLXF*UsMbeWai-t@l*&dEdVMmF_blshP#N9QH-w`BJNO<sh6CeYal1i
>>>> zYh-L-W?*PwYGi0=7A4MWYz$;tLb-$9{Y^|t$U)A?%D~*j#Lr;R#Kgta#Kg$3Uu2!<
>>>> zjryX?*~({Md+?>+QS$x7=il`0?bc6sZ`Vxxl^6N{>i2E;SY*4-T$+0G;)5dxe+2CR
>>>> z@4+)sDPWdQb@%6KTpDVdm)v}?GSpG(w_UV)&i+#e3fJowDZO)JR83lIcbw(hMu}}Y
>>>> z2ZZwYAI-LVx@^G;HdkgxaX&Hnl_l3&{H|3l7uX@Vl5di{>fQQ{pDynFlySp2(z~g)
>>>> z{LIBUzm&K9j_CMw_SIFfPdcT#zmg6g<ji}(R`6geJLk-#o7bK^&&fT}#2zsD`=c9g
>>>> zFUCK<Fz@{2kel&$W6zl<d|WNk#ZsNRd{_N_SJxWvh0*K$j!m)c@oT>{#b(Lp`M3Uj
>>>> zGOKycyEe+n{G(Rmg}jB!)0ySk-!kkj_R7#OT+}pcG0VXh?f+ftRvnyw#hUea^Iyfn
>>>> ze|zgKPKrqe@jYWU?v<50X(n^lZ*G%j$JyCh`*Px|H*K=2WXP)hx>jng+}Q}N^KoDN
>>>> z8dh8T-~Dmrp2?yk3O6Gqbz7O@<TEz<^zIa7d#PKtHKHeAg?V0DMSin^o3F|IEfQWk
>>>> zcmJwBy6&2hKub%G{j3IK(?7m@uI43#1e~wSZJ5sTtDjrp@7@{O3(faN{`Gp}x{$M5
>>>> z{A7`c@pjfYq1Z=JvgZ^-zCC<(HFTBwYhTX$k`7IJX`SM!H}f`Mv+(Op6uVY(<(^o4
>>>> zpyXAj9nF_c-1A<UIel9%6Eh<NBXSA>W=dcRVPvS;*B%(4`P|iK>Vg$XDgN9sr}Df{
>>>> z7X0es=RPHr8RB+*)}q}h%gn?x9PO4y*Qog};x<<LS+lxk$@$kYlG_hXu6p%jvB<%l
>>>> zmcsdI9w!^rFPt^&c~{1?L~DJ4TRPv>t%rn8xi;KBE9A!Dppb9yru|>RCb9PcXWpE>
>>>> zKlQ}fzw*izXI|}|r!O*nb&cP9#VhHRn;B<SRflN2Jl(*;W4e0LD$ORRIdjjhURZH+
>>>> zXWR0Vllb2@>`1LC^xvIctvLCYhRA_6yCS~2&!0SH1xwv(O~<l(HQxHJxzF!T_>+5t
>>>> z^|E$S{MM^8j9J5`sQ6pud{2Lz?k`zncbjvHj%eutjusUol}8;%cbPLCO|e;ZJ^tXe
>>>> z_N{pmM}uCi3UWO3=hMc<s}m1Jx4GS4F(<_N`R|o+)eAK3Yx{o$ygRe!;<_EoF&UhP
>>>> zrslJ=2XA9^$j#UDYwo;ZvZwb!|L%YP%v|ie|7-1PP+q3DZ&vEWgHHrjHv|NzEVjO?
>>>> zKFeRbXv>iTPl?N16Xv@buq_d@TU<MB;uD_jX^$J`&*C>`uX0_s&g9M2C6cKx4E;{?
>>>> zt`1&)Tk-yb?sKMPI~!}xt*d*!tMat!r1`}jul#i@lDB8rnu>ba_-^4!iQ5{|tb3TX
>>>> z>fTMIw2!Me3{Dw*WZotC<4@h<H`zaL+~Es<{Ccj5yS7zyNU!YsTG`^JqA6NkU%vnV
>>>> D66<<J
>>>>
>>>> literal 0
>>>> HcmV?d00001
>>>>
>>>
> 
