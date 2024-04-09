Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6382CD128A
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 19:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F33A1879A0;
	Tue,  9 Apr 2024 21:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YaeDiONA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A41D879E2; Tue,  9 Apr 2024 21:27:07 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C438799C
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 21:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712690818; x=1713295618; i=xypron.glpk@gmx.de;
 bh=1eis0OeG92IEdviIVcv3osjF0ThW8niQ7aVTcyUHgAU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=YaeDiONAMTWTNgC+g1IhuCBZFZfNs8miLny+6cjUBFbePR4Z5AqQNYUPF5oTh8bx
 V0GXd//dPn95gWpX/4bsejuS5MKgATA6+wiI1kUKDmuByBj9XDkMWtNQCRGCz+6jR
 O8xl7s7x7iy68LGa3DgMGmA4eo0kabFAupZ42j7cfjoQeLNFXBP6ieS9SG1RRX08G
 s167gR418DvCY6WfyGWGJ7l6f6aQiM0NGNDuSrKSCjyjg1IfvPGD4txCjDLS6ceKe
 hxnLwDKXogXcnX3eRzI8LKLzxHxdQ5yxkNSpymqKAhe6LxJ8dto9mrGsP6mH+yqej
 kEljDpbp/fn3dX81KQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42nS-1ruH7S2HJo-0002Z0; Tue, 09
 Apr 2024 21:26:58 +0200
Message-ID: <2a818e83-9971-4626-9695-24e7d9c2fdd5@gmx.de>
Date: Tue, 9 Apr 2024 21:26:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] ti:keys Add EFI signature list
To: Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Neha Malcom Francis <n-francis@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jonathan Humphreys <j-humphreys@ti.com>
References: <20240408213349.96610-1-j-humphreys@ti.com>
 <20240408213349.96610-2-j-humphreys@ti.com>
 <ee9a13b7-6b52-4bc8-8876-e194e1a66f92@gmx.de>
 <ec241b23-5523-45d6-aa05-5d1667c34773@ti.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <ec241b23-5523-45d6-aa05-5d1667c34773@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AIZYPbKq322ybf/AYbDoiyb+eJp+SRO8OFiTsReOzPJqTnL9QUV
 xjALqG73Yi2wgeSGWu0FGUSr5Q8Ed9Ab07bPiKShiQzCX0U6BeCAUaSWo7vxWGYTnz5YvSZ
 m6StVGjf//aLvPoMtDv/D3h7W7WK5zv1f9JoPlvwPPHrJ1040TkhMbGRU1XGhcZISPUFavq
 mbcbPHmqCr1FydhWW6sqA==
UI-OutboundReport: notjunk:1;M01:P0:a0NZptqlF+w=;pJioKY9NECqt49kjyKKvaj/b0Sk
 81dUGxnWnjMfhjJ5Q0fkwDShHG6EWMkcF1+Fd3IP9FVK+rjNLRSinqDduNrJ+kXBBmb9Y8gK4
 hLaKHZfPCd9t3+IOfB42i4qdT6YGtxtPi6nVzuw7UTSvyZxP1C1rHWfkUZCKfyoxviuRk4qsK
 ThNJuiFV3iEwPJ+X8TcyGt0skOO8gIhtm8aN6lVnmckSrqLqa6Pze9q5n6/wqbjRRjhtxUmdo
 jytLYOhtAesPgonBdPx0zfFz6AO33V3Hga8dfkGzLYVlHIB7TrKa0W8bTcpUWxaV+3lWckYBs
 AXvba+k7Tveh4g8MOCRPI99GS/Qs470CgbA6p04OAvNeaKpZfdulnRnsldiv0S6G8ORFXdc8G
 DZAh09DWkJXinuGXdNy9YZFLW1z3iWMhHSR7g2Zi61vNzry/yO+TXh22nQqYq9KVTskBUU9gh
 h5+7ShDx2+X/+3g3f8LRYM9A3coAUJtIt+dEjnduZiWXgLp7EdASdqc/AAr6I3bPS+mRUkH1P
 locqXn+CjmxSMHIF9DxGca8qJbvK1VSzyBCfJgKYzqjMdptaEVl4Hc4QUuT7dGArPXLyO1YyO
 dKJ4zR6dlrTRGi0ynnZ+d2LWN1SJ3Jc+TEqq3UVf5EC+P4s2ljdMb5V2uQadtEQ2wASFLCYsl
 MWrQ6Cw/hN3LeBiuzNoOZK+mUE+R+//3/B4NpMjVE3iZIiM+MBa28WCVwbEgJDgm2Fkxf86p7
 FFlKVDVUyMdlj7MOPpZwsF9cWMEWrM9WZwG1NN4Zy35rpwkdd9jezA/zbKhuwgxjHw0WiZMBB
 jeGFhQWlFW57srMdaN4M1CJFJ7RLpQ1T8Amo8Ho6875RY=
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

On 4/9/24 14:14, Andrew Davis wrote:
> On 4/8/24 10:34 PM, Heinrich Schuchardt wrote:
>> On 4/8/24 23:33, Jonathan Humphreys wrote:
>>> EFI signature list using TI dummy keys.
>>
>> Adding vendor public keys into the code base to lock down generated
>> binaries to the vendors unpublished private key does not match well wit=
h
>> the intent of the GNU public license.
>>
>
> The matching private keys are already published in this same
> repo/directory (arch/arm/mach-k3/keys).
>
> Andrew

Why should we create signed capsules which are already compromised by
publishing the private key?

Best regards

Heinrich

>
>> Best regards
>>
>> Heinrich
>>
>>>
>>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>>> ---
>>> =C2=A0 arch/arm/mach-k3/keys/custMpk.esl | Bin 0 -> 1523 bytes
>>> =C2=A0 1 file changed, 0 insertions(+), 0 deletions(-)
>>> =C2=A0 create mode 100644 arch/arm/mach-k3/keys/custMpk.esl
>>>
>>> diff --git a/arch/arm/mach-k3/keys/custMpk.esl
>>> b/arch/arm/mach-k3/keys/custMpk.esl
>>> new file mode 100644
>>> index
>>> 0000000000000000000000000000000000000000..2feb704e0a5fd126410de451d3c0=
fa4d3edccc52
>>> GIT binary patch
>>> literal 1523
>>> zcmZ1&d0^?2Da*aux2_hA(f&~MnUw(yu0v@E4?-F=3Du^u*PVqVQ8QZ((-^A*$m*Kg7c
>>> z&78AJODc2mtxpELY@Awc9&O)w85y}*84Mcd8gd(OvN4CUun9AT2E#ZUJWL@GhWtR)
>>> zKpA!(HkZVloWx>7bput902hy3NNPo5v4Uq_aY<2WZfaf$h@G5YRFGekSdyAzC~P1I
>>> zQpnB26;PC)oLXF*UsMbeWai-t@l*&dEdVMmF_blshP#N9QH-w`BJNO<sh6CeYal1i
>>> zYh-L-W?*PwYGi0=3D7A4MWYz$;tLb-$9{Y^|t$U)A?%D~*j#Lr;R#Kgta#Kg$3Uu2!<
>>> zjryX?*~({Md+?>+QS$x7=3Dil`0?bc6sZ`Vxxl^6N{>i2E;SY*4-T$+0G;)5dxe+2CR
>>> z@4+)sDPWdQb@%6KTpDVdm)v}?GSpG(w_UV)&i+#e3fJowDZO)JR83lIcbw(hMu}}Y
>>> z2ZZwYAI-LVx@^G;HdkgxaX&Hnl_l3&{H|3l7uX@Vl5di{>fQQ{pDynFlySp2(z~g)
>>> z{LIBUzm&K9j_CMw_SIFfPdcT#zmg6g<ji}(R`6geJLk-#o7bK^&&fT}#2zsD`=3Dc9g
>>> zFUCK<Fz@{2kel&$W6zl<d|WNk#ZsNRd{_N_SJxWvh0*K$j!m)c@oT>{#b(Lp`M3Uj
>>> zGOKycyEe+n{G(Rmg}jB!)0ySk-!kkj_R7#OT+}pcG0VXh?f+ftRvnyw#hUea^Iyfn
>>> ze|zgKPKrqe@jYWU?v<50X(n^lZ*G%j$JyCh`*Px|H*K=3D2WXP)hx>jng+}Q}N^KoDN
>>> z8dh8T-~Dmrp2?yk3O6Gqbz7O@<TEz<^zIa7d#PKtHKHeAg?V0DMSin^o3F|IEfQWk
>>> zcmJwBy6&2hKub%G{j3IK(?7m@uI43#1e~wSZJ5sTtDjrp@7@{O3(faN{`Gp}x{$M5
>>> z{A7`c@pjfYq1Z=3DJvgZ^-zCC<(HFTBwYhTX$k`7IJX`SM!H}f`Mv+(Op6uVY(<(^o4
>>> zpyXAj9nF_c-1A<UIel9%6Eh<NBXSA>W=3DdcRVPvS;*B%(4`P|iK>Vg$XDgN9sr}Df{
>>> z7X0es=3DRPHr8RB+*)}q}h%gn?x9PO4y*Qog};x<<LS+lxk$@$kYlG_hXu6p%jvB<%l
>>> zmcsdI9w!^rFPt^&c~{1?L~DJ4TRPv>t%rn8xi;KBE9A!Dppb9yru|>RCb9PcXWpE>
>>> zKlQ}fzw*izXI|}|r!O*nb&cP9#VhHRn;B<SRflN2Jl(*;W4e0LD$ORRIdjjhURZH+
>>> zXWR0Vllb2@>`1LC^xvIctvLCYhRA_6yCS~2&!0SH1xwv(O~<l(HQxHJxzF!T_>+5t
>>> z^|E$S{MM^8j9J5`sQ6pud{2Lz?k`zncbjvHj%eutjusUol}8;%cbPLCO|e;ZJ^tXe
>>> z_N{pmM}uCi3UWO3=3DhMc<s}m1Jx4GS4F(<_N`R|o+)eAK3Yx{o$ygRe!;<_EoF&UhP
>>> zrslJ=3D2XA9^$j#UDYwo;ZvZwb!|L%YP%v|ie|7-1PP+q3DZ&vEWgHHrjHv|NzEVjO?
>>> zKFeRbXv>iTPl?N16Xv@buq_d@TU<MB;uD_jX^$J`&*C>`uX0_s&g9M2C6cKx4E;{?
>>> zt`1&)Tk-yb?sKMPI~!}xt*d*!tMat!r1`}jul#i@lDB8rnu>ba_-^4!iQ5{|tb3TX
>>> z>fTMIw2!Me3{Dw*WZotC<4@h<H`zaL+~Es<{Ccj5yS7zyNU!YsTG`^JqA6NkU%vnV
>>> D66<<J
>>>
>>> literal 0
>>> HcmV?d00001
>>>
>>

