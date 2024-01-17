Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B15FC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 12:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B0D887AFF;
	Wed, 17 Jan 2024 13:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=supermicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=supermicro.com header.i=@supermicro.com header.b="C4304Pqu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 549CD8753E; Wed, 17 Jan 2024 01:25:16 +0100 (CET)
Received: from MGB.supermicro.com (mgb.supermicro.com [207.212.57.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BBA486FB0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 01:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=supermicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liuw@supermicro.com
Received: from pps.filterd (MGB.supermicro.com [127.0.0.1])
 by MGB.supermicro.com (8.17.1.19/8.17.1.19) with ESMTP id 40GLTKWq013531
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 16:25:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=supermicro.com;
 h=from : to :
 subject : date : message-id : content-type : mime-version; s=DKIM;
 bh=bDkqFuZRievQmB3wk1hOht6UqOr+LxpaQekbgjG1dp4=;
 b=C4304PquZ+elJHyC8ki/5jezz+Aj6H/vz9fJejUPX1PeOaBH26g4dK6irromaZw+ISmh
 ffEifhC4IOggAGPDMGo3YKWFUiOLwL20m8oXfTQFH+makErG885sE8ovpcO/1iCceTo2
 AjTtubC4vX5svEqs0jRSltzg6EDTORz0ztNJYTaf5UA5IdI53BoVjjKE9BWukUiB3jZs
 NmxSneMBc+W6ulqHOSXWx9Z5Jab26DxZueGClzkRqJsEAaNmgR4cYnSlMVKtvLZABmnO
 ASWGht8OJ3Sj3mMibnYOdgTCYyDORqQW/ApkhTDYKWxZ2NOazVV3FYJTmfFopdX9d48i uA== 
Received: from ex2013-mbx5.supermicro.com (EX2013-MBX5.supermicro.com
 [10.2.1.182]) by MGB.supermicro.com (PPS) with ESMTPS id 3vku0wb99v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 16:25:08 -0800
Received: from us-ex2019-mbx5.supermicro.com (10.2.6.161) by
 EX2013-MBX5.supermicro.com (10.2.1.182) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 16 Jan 2024 16:25:07 -0800
Received: from us-ex2019-mbx1.supermicro.com (10.2.6.157) by
 us-ex2019-mbx5.supermicro.com (10.2.6.161) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 16 Jan 2024 16:25:07 -0800
Received: from us-ex2019-mbx1.supermicro.com ([fe80::37c2:47e5:2f5d:450f]) by
 us-ex2019-mbx1.supermicro.com ([fe80::37c2:47e5:2f5d:450f%16]) with
 mapi id 15.02.1118.037; Tue, 16 Jan 2024 16:25:07 -0800
From: Liu Wang <liuw@supermicro.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Could you please help me in resolving the "arch/arm/lib/vectors.S:87:
 Error: no such instruction: `b reset' ?"
Thread-Topic: Could you please help me in resolving the
 "arch/arm/lib/vectors.S:87: Error: no such instruction: `b reset' ?"
Thread-Index: AdpI24I3kjWF6EnATLOPMIhQOQ7T3g==
Date: Wed, 17 Jan 2024 00:25:07 +0000
Message-ID: <2dba1330181940c78b5ad47f18ee43fa@supermicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.8.23]
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Mailman-Approved-At: Wed, 17 Jan 2024 13:27:11 +0100
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Sir/Madam,

Could you please help me in resolving the "arch/arm/lib/vectors.S:87: Error=
: no such instruction: `b reset' ?"

Sincerely,
Liu Wang
liuw@liuw-SYS-E100-12T-H:~/Downloads/u-boot$ make cse_ptjob_cb3_r102_defcon=
fig
#
# configuration written to .config
#
liuw@liuw-SYS-E100-12T-H:~/Downloads/u-boot$ make all
scripts/kconfig/conf  --syncconfig Kconfig
  CFG     u-boot.cfg
  GEN     include/autoconf.mk
  GEN     include/autoconf.mk.dep
  UPD     include/generated/timestamp_autogenerated.h
  HOSTCC  tools/mkenvimage.o
  HOSTLD  tools/mkenvimage
  HOSTCC  tools/dumpimage.o
  HOSTLD  tools/dumpimage
  HOSTCC  tools/mkimage.o
  HOSTLD  tools/mkimage
  LD      arch/arm/cpu/built-in.o
  LD      arch/arm/cpu//built-in.o
  AS      arch/arm/lib/vectors.o
arch/arm/lib/vectors.S: Assembler messages:
arch/arm/lib/vectors.S:87: Error: no such instruction: `b reset'
arch/arm/lib/vectors.S:87: Error: no such instruction: `ldr pc,_undefined_i=
nstruction'
arch/arm/lib/vectors.S:87: Error: no such instruction: `ldr pc,_software_in=
terrupt'
arch/arm/lib/vectors.S:87: Error: no such instruction: `ldr pc,_prefetch_ab=
ort'
arch/arm/lib/vectors.S:87: Error: no such instruction: `ldr pc,_data_abort'
arch/arm/lib/vectors.S:87: Error: no such instruction: `ldr pc,_not_used'
arch/arm/lib/vectors.S:87: Error: no such instruction: `ldr pc,_irq'
arch/arm/lib/vectors.S:87: Error: no such instruction: `ldr pc,_fiq'
arch/arm/lib/vectors.S:153: Warning: value 0x000000000badc0de truncated to =
0x000000000000c0de
arch/arm/lib/vectors.S:156: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:157: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:158: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:237: Error: Bad parameter list for macro `get_irq_st=
ack'
arch/arm/lib/vectors.S:241: Error: Bad parameter list for macro `get_fiq_st=
ack'
arch/arm/lib/vectors.S:249: Error: alignment not a power of 2
arch/arm/lib/vectors.S:251: Error: no such instruction: `ldr r13,IRQ_STACK_=
START_IN@setup our mode stack'
arch/arm/lib/vectors.S:251: Error: too many memory references for `str'
arch/arm/lib/vectors.S:251: Error: no such instruction: `mrs lr,spsr@get th=
e spsr'
arch/arm/lib/vectors.S:251: Error: too many memory references for `str'
arch/arm/lib/vectors.S:251: Error: expecting operand after ','; got nothing
arch/arm/lib/vectors.S:251: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:251: Error: no such instruction: `msr spsr,r13@switc=
h modes,make sure moves will execute'
arch/arm/lib/vectors.S:251: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:251: Warning: `pc' is not valid here (expected `(%rs=
i)')
arch/arm/lib/vectors.S:251: Error: junk `@jump to next instruction&switch m=
odes.' after expression
arch/arm/lib/vectors.S:251: Warning: `lr@jump to next instruction&switch mo=
des.' is not valid here (expected `(%rdi)')
arch/arm/lib/vectors.S:251: Warning: no instruction mnemonic suffix given a=
nd no register operands; using default for `movs'
arch/arm/lib/vectors.S:252: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:252: Error: too many memory references for `sub'
arch/arm/lib/vectors.S:252: Error: no such instruction: `stmia sp,{r0 - r12=
}@Save user registers (now in svc mode)r0-r12'
arch/arm/lib/vectors.S:252: Error: no such instruction: `ldr r2,IRQ_STACK_S=
TART_IN'
arch/arm/lib/vectors.S:252: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:252: Error: no such instruction: `ldmia r2,{r2 - r3}=
'
arch/arm/lib/vectors.S:252: Error: too many memory references for `add'
arch/arm/lib/vectors.S:252: Error: too many memory references for `add'
arch/arm/lib/vectors.S:252: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:252: Error: no such instruction: `stmia r5,{r0 - r3}=
@save sp_SVC,lr_SVC,pc,cpsr'
arch/arm/lib/vectors.S:252: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:253: Error: no such instruction: `bl do_undefined_in=
struction'
arch/arm/lib/vectors.S:255: Error: alignment not a power of 2
arch/arm/lib/vectors.S:257: Error: no such instruction: `ldr r13,IRQ_STACK_=
START_IN@setup our mode stack'
arch/arm/lib/vectors.S:257: Error: too many memory references for `str'
arch/arm/lib/vectors.S:257: Error: no such instruction: `mrs lr,spsr@get th=
e spsr'
arch/arm/lib/vectors.S:257: Error: too many memory references for `str'
arch/arm/lib/vectors.S:257: Error: expecting operand after ','; got nothing
arch/arm/lib/vectors.S:257: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:257: Error: no such instruction: `msr spsr,r13@switc=
h modes,make sure moves will execute'
arch/arm/lib/vectors.S:257: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:257: Warning: `pc' is not valid here (expected `(%rs=
i)')
arch/arm/lib/vectors.S:257: Error: junk `@jump to next instruction&switch m=
odes.' after expression
arch/arm/lib/vectors.S:257: Warning: `lr@jump to next instruction&switch mo=
des.' is not valid here (expected `(%rdi)')
arch/arm/lib/vectors.S:257: Warning: no instruction mnemonic suffix given a=
nd no register operands; using default for `movs'
arch/arm/lib/vectors.S:258: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:258: Error: too many memory references for `sub'
arch/arm/lib/vectors.S:258: Error: no such instruction: `stmia sp,{r0 - r12=
}@Save user registers (now in svc mode)r0-r12'
arch/arm/lib/vectors.S:258: Error: no such instruction: `ldr r2,IRQ_STACK_S=
TART_IN'
arch/arm/lib/vectors.S:258: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:258: Error: no such instruction: `ldmia r2,{r2 - r3}=
'
arch/arm/lib/vectors.S:258: Error: too many memory references for `add'
arch/arm/lib/vectors.S:258: Error: too many memory references for `add'
arch/arm/lib/vectors.S:258: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:258: Error: no such instruction: `stmia r5,{r0 - r3}=
@save sp_SVC,lr_SVC,pc,cpsr'
arch/arm/lib/vectors.S:258: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:259: Error: no such instruction: `bl do_software_int=
errupt'
arch/arm/lib/vectors.S:261: Error: alignment not a power of 2
arch/arm/lib/vectors.S:263: Error: no such instruction: `ldr r13,IRQ_STACK_=
START_IN@setup our mode stack'
arch/arm/lib/vectors.S:263: Error: too many memory references for `str'
arch/arm/lib/vectors.S:263: Error: no such instruction: `mrs lr,spsr@get th=
e spsr'
arch/arm/lib/vectors.S:263: Error: too many memory references for `str'
arch/arm/lib/vectors.S:263: Error: expecting operand after ','; got nothing
arch/arm/lib/vectors.S:263: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:263: Error: no such instruction: `msr spsr,r13@switc=
h modes,make sure moves will execute'
arch/arm/lib/vectors.S:263: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:263: Warning: `pc' is not valid here (expected `(%rs=
i)')
arch/arm/lib/vectors.S:263: Error: junk `@jump to next instruction&switch m=
odes.' after expression
arch/arm/lib/vectors.S:263: Warning: `lr@jump to next instruction&switch mo=
des.' is not valid here (expected `(%rdi)')
arch/arm/lib/vectors.S:263: Warning: no instruction mnemonic suffix given a=
nd no register operands; using default for `movs'
arch/arm/lib/vectors.S:264: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:264: Error: too many memory references for `sub'
arch/arm/lib/vectors.S:264: Error: no such instruction: `stmia sp,{r0 - r12=
}@Save user registers (now in svc mode)r0-r12'
arch/arm/lib/vectors.S:264: Error: no such instruction: `ldr r2,IRQ_STACK_S=
TART_IN'
arch/arm/lib/vectors.S:264: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:264: Error: no such instruction: `ldmia r2,{r2 - r3}=
'
arch/arm/lib/vectors.S:264: Error: too many memory references for `add'
arch/arm/lib/vectors.S:264: Error: too many memory references for `add'
arch/arm/lib/vectors.S:264: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:264: Error: no such instruction: `stmia r5,{r0 - r3}=
@save sp_SVC,lr_SVC,pc,cpsr'
arch/arm/lib/vectors.S:264: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:265: Error: no such instruction: `bl do_prefetch_abo=
rt'
arch/arm/lib/vectors.S:267: Error: alignment not a power of 2
arch/arm/lib/vectors.S:269: Error: no such instruction: `ldr r13,IRQ_STACK_=
START_IN@setup our mode stack'
arch/arm/lib/vectors.S:269: Error: too many memory references for `str'
arch/arm/lib/vectors.S:269: Error: no such instruction: `mrs lr,spsr@get th=
e spsr'
arch/arm/lib/vectors.S:269: Error: too many memory references for `str'
arch/arm/lib/vectors.S:269: Error: expecting operand after ','; got nothing
arch/arm/lib/vectors.S:269: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:269: Error: no such instruction: `msr spsr,r13@switc=
h modes,make sure moves will execute'
arch/arm/lib/vectors.S:269: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:269: Warning: `pc' is not valid here (expected `(%rs=
i)')
arch/arm/lib/vectors.S:269: Error: junk `@jump to next instruction&switch m=
odes.' after expression
arch/arm/lib/vectors.S:269: Warning: `lr@jump to next instruction&switch mo=
des.' is not valid here (expected `(%rdi)')
arch/arm/lib/vectors.S:269: Warning: no instruction mnemonic suffix given a=
nd no register operands; using default for `movs'
arch/arm/lib/vectors.S:270: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:270: Error: too many memory references for `sub'
arch/arm/lib/vectors.S:270: Error: no such instruction: `stmia sp,{r0 - r12=
}@Save user registers (now in svc mode)r0-r12'
arch/arm/lib/vectors.S:270: Error: no such instruction: `ldr r2,IRQ_STACK_S=
TART_IN'
arch/arm/lib/vectors.S:270: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:270: Error: no such instruction: `ldmia r2,{r2 - r3}=
'
arch/arm/lib/vectors.S:270: Error: too many memory references for `add'
arch/arm/lib/vectors.S:270: Error: too many memory references for `add'
arch/arm/lib/vectors.S:270: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:270: Error: no such instruction: `stmia r5,{r0 - r3}=
@save sp_SVC,lr_SVC,pc,cpsr'
arch/arm/lib/vectors.S:270: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:271: Error: no such instruction: `bl do_data_abort'
arch/arm/lib/vectors.S:273: Error: alignment not a power of 2
arch/arm/lib/vectors.S:275: Error: no such instruction: `ldr r13,IRQ_STACK_=
START_IN@setup our mode stack'
arch/arm/lib/vectors.S:275: Error: too many memory references for `str'
arch/arm/lib/vectors.S:275: Error: no such instruction: `mrs lr,spsr@get th=
e spsr'
arch/arm/lib/vectors.S:275: Error: too many memory references for `str'
arch/arm/lib/vectors.S:275: Error: expecting operand after ','; got nothing
arch/arm/lib/vectors.S:275: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:275: Error: no such instruction: `msr spsr,r13@switc=
h modes,make sure moves will execute'
arch/arm/lib/vectors.S:275: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:275: Warning: `pc' is not valid here (expected `(%rs=
i)')
arch/arm/lib/vectors.S:275: Error: junk `@jump to next instruction&switch m=
odes.' after expression
arch/arm/lib/vectors.S:275: Warning: `lr@jump to next instruction&switch mo=
des.' is not valid here (expected `(%rdi)')
arch/arm/lib/vectors.S:275: Warning: no instruction mnemonic suffix given a=
nd no register operands; using default for `movs'
arch/arm/lib/vectors.S:276: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:276: Error: too many memory references for `sub'
arch/arm/lib/vectors.S:276: Error: no such instruction: `stmia sp,{r0 - r12=
}@Save user registers (now in svc mode)r0-r12'
arch/arm/lib/vectors.S:276: Error: no such instruction: `ldr r2,IRQ_STACK_S=
TART_IN'
arch/arm/lib/vectors.S:276: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:276: Error: no such instruction: `ldmia r2,{r2 - r3}=
'
arch/arm/lib/vectors.S:276: Error: too many memory references for `add'
arch/arm/lib/vectors.S:276: Error: too many memory references for `add'
arch/arm/lib/vectors.S:276: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:276: Error: no such instruction: `stmia r5,{r0 - r3}=
@save sp_SVC,lr_SVC,pc,cpsr'
arch/arm/lib/vectors.S:276: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:277: Error: no such instruction: `bl do_not_used'
arch/arm/lib/vectors.S:280: Error: alignment not a power of 2
arch/arm/lib/vectors.S:282: Error: no such instruction: `ldr r13,IRQ_STACK_=
START_IN@setup our mode stack'
arch/arm/lib/vectors.S:282: Error: too many memory references for `str'
arch/arm/lib/vectors.S:282: Error: no such instruction: `mrs lr,spsr@get th=
e spsr'
arch/arm/lib/vectors.S:282: Error: too many memory references for `str'
arch/arm/lib/vectors.S:282: Error: expecting operand after ','; got nothing
arch/arm/lib/vectors.S:282: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:282: Error: no such instruction: `msr spsr,r13@switc=
h modes,make sure moves will execute'
arch/arm/lib/vectors.S:282: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:282: Warning: `pc' is not valid here (expected `(%rs=
i)')
arch/arm/lib/vectors.S:282: Error: junk `@jump to next instruction&switch m=
odes.' after expression
arch/arm/lib/vectors.S:282: Warning: `lr@jump to next instruction&switch mo=
des.' is not valid here (expected `(%rdi)')
arch/arm/lib/vectors.S:282: Warning: no instruction mnemonic suffix given a=
nd no register operands; using default for `movs'
arch/arm/lib/vectors.S:283: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:283: Error: too many memory references for `sub'
arch/arm/lib/vectors.S:283: Error: no such instruction: `stmia sp,{r0 - r12=
}@Save user registers (now in svc mode)r0-r12'
arch/arm/lib/vectors.S:283: Error: no such instruction: `ldr r2,IRQ_STACK_S=
TART_IN'
arch/arm/lib/vectors.S:283: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:283: Error: no such instruction: `ldmia r2,{r2 - r3}=
'
arch/arm/lib/vectors.S:283: Error: too many memory references for `add'
arch/arm/lib/vectors.S:283: Error: too many memory references for `add'
arch/arm/lib/vectors.S:283: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:283: Error: no such instruction: `stmia r5,{r0 - r3}=
@save sp_SVC,lr_SVC,pc,cpsr'
arch/arm/lib/vectors.S:283: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:284: Error: no such instruction: `bl do_irq'
arch/arm/lib/vectors.S:286: Error: alignment not a power of 2
arch/arm/lib/vectors.S:288: Error: no such instruction: `ldr r13,IRQ_STACK_=
START_IN@setup our mode stack'
arch/arm/lib/vectors.S:288: Error: too many memory references for `str'
arch/arm/lib/vectors.S:288: Error: no such instruction: `mrs lr,spsr@get th=
e spsr'
arch/arm/lib/vectors.S:288: Error: too many memory references for `str'
arch/arm/lib/vectors.S:288: Error: expecting operand after ','; got nothing
arch/arm/lib/vectors.S:288: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:288: Error: no such instruction: `msr spsr,r13@switc=
h modes,make sure moves will execute'
arch/arm/lib/vectors.S:288: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:288: Warning: `pc' is not valid here (expected `(%rs=
i)')
arch/arm/lib/vectors.S:288: Error: junk `@jump to next instruction&switch m=
odes.' after expression
arch/arm/lib/vectors.S:288: Warning: `lr@jump to next instruction&switch mo=
des.' is not valid here (expected `(%rdi)')
arch/arm/lib/vectors.S:288: Warning: no instruction mnemonic suffix given a=
nd no register operands; using default for `movs'
arch/arm/lib/vectors.S:289: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:289: Error: too many memory references for `sub'
arch/arm/lib/vectors.S:289: Error: no such instruction: `stmia sp,{r0 - r12=
}@Save user registers (now in svc mode)r0-r12'
arch/arm/lib/vectors.S:289: Error: no such instruction: `ldr r2,IRQ_STACK_S=
TART_IN'
arch/arm/lib/vectors.S:289: Error: junk at end of line, first unrecognized =
character is `@'
arch/arm/lib/vectors.S:289: Error: no such instruction: `ldmia r2,{r2 - r3}=
'
arch/arm/lib/vectors.S:289: Error: too many memory references for `add'
arch/arm/lib/vectors.S:289: Error: too many memory references for `add'
arch/arm/lib/vectors.S:289: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:289: Error: no such instruction: `stmia r5,{r0 - r3}=
@save sp_SVC,lr_SVC,pc,cpsr'
arch/arm/lib/vectors.S:289: Error: too many memory references for `mov'
arch/arm/lib/vectors.S:290: Error: no such instruction: `bl do_fiq'
arch/arm/lib/vectors.S:120: Error: alignment padding (2 bytes) not a multip=
le of 4
arch/arm/lib/vectors.S:120: Error: alignment padding (2 bytes) not a multip=
le of 4
make[1]: *** [scripts/Makefile.build:301: arch/arm/lib/vectors.o] Error 1
make: *** [Makefile:1780: arch/arm/lib] Error 2
liuw@liuw-SYS-E100-12T-H:~/Downloads/u-boot
