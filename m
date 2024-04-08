Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AA0CD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 22:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B0E2882D0;
	Tue,  9 Apr 2024 00:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="q+Bjrg/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C558A88159; Mon,  8 Apr 2024 23:34:19 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B357988134
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 23:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 438LYCkd097860;
 Mon, 8 Apr 2024 16:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712612052;
 bh=Mi9tx8jYkAgc2Sy/0KQB4A75ohrahV93t3s/USyLeDk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=q+Bjrg/H+wMFZQKS3S3UDFwM4I1/ClhQqNA2od7hScy6SbajVeWEFUA8v5jDEB6nW
 qtjrsS9/XHoT/bFrLU+PfFNEv7NlS3YVmvY+z3QmeF18LBF+Vh3GYQyqf8DjQXOCDW
 Y5Qo7w00A90d8C3JrG9NslEudsUARsYAbCwGdez8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 438LYCun069542
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Apr 2024 16:34:12 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 16:34:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 16:34:11 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 438LYBOm106503;
 Mon, 8 Apr 2024 16:34:11 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Simon Glass <sjg@chromium.org>, Neha Malcom Francis <n-francis@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Andrew Davis <afd@ti.com>, Nikhil M Jain
 <n-jain1@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh
 Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH 01/13] ti:keys Add EFI signature list
Date: Mon, 8 Apr 2024 16:33:37 -0500
Message-ID: <20240408213349.96610-2-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408213349.96610-1-j-humphreys@ti.com>
References: <20240408213349.96610-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 09 Apr 2024 00:46:15 +0200
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

EFI signature list using TI dummy keys.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 arch/arm/mach-k3/keys/custMpk.esl | Bin 0 -> 1523 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-k3/keys/custMpk.esl

diff --git a/arch/arm/mach-k3/keys/custMpk.esl b/arch/arm/mach-k3/keys/custMpk.esl
new file mode 100644
index 0000000000000000000000000000000000000000..2feb704e0a5fd126410de451d3c0fa4d3edccc52
GIT binary patch
literal 1523
zcmZ1&d0^?2Da*aux2_hA(f&~MnUw(yu0v@E4?-F=u^u*PVqVQ8QZ((-^A*$m*Kg7c
z&78AJODc2mtxpELY@Awc9&O)w85y}*84Mcd8gd(OvN4CUun9AT2E#ZUJWL@GhWtR)
zKpA!(HkZVloWx>7bput902hy3NNPo5v4Uq_aY<2WZfaf$h@G5YRFGekSdyAzC~P1I
zQpnB26;PC)oLXF*UsMbeWai-t@l*&dEdVMmF_blshP#N9QH-w`BJNO<sh6CeYal1i
zYh-L-W?*PwYGi0=7A4MWYz$;tLb-$9{Y^|t$U)A?%D~*j#Lr;R#Kgta#Kg$3Uu2!<
zjryX?*~({Md+?>+QS$x7=il`0?bc6sZ`Vxxl^6N{>i2E;SY*4-T$+0G;)5dxe+2CR
z@4+)sDPWdQb@%6KTpDVdm)v}?GSpG(w_UV)&i+#e3fJowDZO)JR83lIcbw(hMu}}Y
z2ZZwYAI-LVx@^G;HdkgxaX&Hnl_l3&{H|3l7uX@Vl5di{>fQQ{pDynFlySp2(z~g)
z{LIBUzm&K9j_CMw_SIFfPdcT#zmg6g<ji}(R`6geJLk-#o7bK^&&fT}#2zsD`=c9g
zFUCK<Fz@{2kel&$W6zl<d|WNk#ZsNRd{_N_SJxWvh0*K$j!m)c@oT>{#b(Lp`M3Uj
zGOKycyEe+n{G(Rmg}jB!)0ySk-!kkj_R7#OT+}pcG0VXh?f+ftRvnyw#hUea^Iyfn
ze|zgKPKrqe@jYWU?v<50X(n^lZ*G%j$JyCh`*Px|H*K=2WXP)hx>jng+}Q}N^KoDN
z8dh8T-~Dmrp2?yk3O6Gqbz7O@<TEz<^zIa7d#PKtHKHeAg?V0DMSin^o3F|IEfQWk
zcmJwBy6&2hKub%G{j3IK(?7m@uI43#1e~wSZJ5sTtDjrp@7@{O3(faN{`Gp}x{$M5
z{A7`c@pjfYq1Z=JvgZ^-zCC<(HFTBwYhTX$k`7IJX`SM!H}f`Mv+(Op6uVY(<(^o4
zpyXAj9nF_c-1A<UIel9%6Eh<NBXSA>W=dcRVPvS;*B%(4`P|iK>Vg$XDgN9sr}Df{
z7X0es=RPHr8RB+*)}q}h%gn?x9PO4y*Qog};x<<LS+lxk$@$kYlG_hXu6p%jvB<%l
zmcsdI9w!^rFPt^&c~{1?L~DJ4TRPv>t%rn8xi;KBE9A!Dppb9yru|>RCb9PcXWpE>
zKlQ}fzw*izXI|}|r!O*nb&cP9#VhHRn;B<SRflN2Jl(*;W4e0LD$ORRIdjjhURZH+
zXWR0Vllb2@>`1LC^xvIctvLCYhRA_6yCS~2&!0SH1xwv(O~<l(HQxHJxzF!T_>+5t
z^|E$S{MM^8j9J5`sQ6pud{2Lz?k`zncbjvHj%eutjusUol}8;%cbPLCO|e;ZJ^tXe
z_N{pmM}uCi3UWO3=hMc<s}m1Jx4GS4F(<_N`R|o+)eAK3Yx{o$ygRe!;<_EoF&UhP
zrslJ=2XA9^$j#UDYwo;ZvZwb!|L%YP%v|ie|7-1PP+q3DZ&vEWgHHrjHv|NzEVjO?
zKFeRbXv>iTPl?N16Xv@buq_d@TU<MB;uD_jX^$J`&*C>`uX0_s&g9M2C6cKx4E;{?
zt`1&)Tk-yb?sKMPI~!}xt*d*!tMat!r1`}jul#i@lDB8rnu>ba_-^4!iQ5{|tb3TX
z>fTMIw2!Me3{Dw*WZotC<4@h<H`zaL+~Es<{Ccj5yS7zyNU!YsTG`^JqA6NkU%vnV
D66<<J

literal 0
HcmV?d00001

-- 
2.34.1

