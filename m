Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83C3C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 13:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75DEA839A5;
	Fri, 25 Jul 2025 15:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dQTZCipH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58E73839AD; Fri, 25 Jul 2025 15:26:53 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27B7483993
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 15:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-42a56f2e953so868394b6e.2
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 06:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753450009; x=1754054809; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OaAZqow1Tmfcjg53WK4W2tQzPHk09bwXvSW+6pZPRK0=;
 b=dQTZCipHURhZi1TK8Q43r8a3sQo6wEc7T39c83PaRllyPQxp0owbD1gEpDN9oi6AUR
 b+RbIDKq0tHc2yiF8uQGmZUZTQWdE8M27OhWWnjuDpsbiC63ALwRbUmUbaFlOf/5x3DC
 U579uTzlVRzH+7YH2YatdwnoIG9dawE7Z61mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753450009; x=1754054809;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OaAZqow1Tmfcjg53WK4W2tQzPHk09bwXvSW+6pZPRK0=;
 b=Y7TdDZdSOetBcd4/fWfMe4fIvQDp69BP/ahbwyH/UGq9Ao6qALI3sDg2uTBiOU+kUs
 7Sz11AVFCzivpYzR2LLcVlUFaJxcb3cuoJWbom68slbn2DnoK3N43N3K8uoinvbhKyVh
 Lk85T7HLLRmdEgY3J6n00+tAvYUsVXRdgje4K0N35Tb0jB5v7OVqgov0JVWSwrTnefQZ
 24HUfH13al1tcAEnKG0A8zSs8G6GFiHQF0M4kR90yWS+5cXIloBph9Z3eoQGJAC2I/o6
 hwelfCjWxiKymYDCjAcaa9DXFmmo0RKrssd6tfkXuab30FURelBDte896JaqAhSuLkc6
 Hebg==
X-Gm-Message-State: AOJu0Yw5tqDm6SMMybCkC4I5LlXYrVaTRO2XvSevXUsM/Azq7BKxCNn0
 5Eh/Obn0YKUYPNnECevOvS0zQeUiR7P+mvL8+WbV0pWO/RXkeFtACdvf9Ego2B3QaqjHwwVWejj
 3CSJ+njM=
X-Gm-Gg: ASbGncuel1nSMXtx9ySjOFd7fLOAkbhvL//GIqH9/yvXBzYKst91zrLIGAyFGSMO3NB
 GdCXIp/TURCuzGcmh0XL1HnoLaOgI83D344zptiBMvuOlD2nrE6G/ikW6QfkjTy//I599g/vqQm
 dPDdh86oGiGLOy1IIwEv8MdqY0Ikf4tgVELNjghYnN6NPid580j6ZWTEuU35dDJOeK4YgAdCOY9
 2jpTbreaUZgtK31PgOWP8A9qaCfCbLO4v0Qkq3/1vZa1zHtEvYdV8MhJwMOpgEDf6dTh5rVirV2
 bu1VQwpThfsM773X1Bu5+U0hZ8Abnh1+/CjTOPFcz/wLXsr3pru7NE9r7La5L4HKqXWwkVFUKRy
 I0CFtx1GlA+Eeaoaz9S+7+3xBO679p6HThCIlD5oabZvGPRD36ij9fl2L
X-Google-Smtp-Source: AGHT+IH40asDs8QM3BhW6KG+iI93LXOM0vFFzvetfySF4irf4yGF1YkUbFVDJaL3jI+u21oMfYtiEA==
X-Received: by 2002:a05:6808:1901:b0:406:45ae:b0 with SMTP id
 5614622812f47-42bb9ef5d29mr876189b6e.35.1753450008751; 
 Fri, 25 Jul 2025 06:26:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-42a330919fcsm600410b6e.32.2025.07.25.06.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 06:26:47 -0700 (PDT)
Date: Fri, 25 Jul 2025 07:26:45 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20250725132645.GA1807455@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fa5E/yQgjVAiXiG/"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
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


--Fa5E/yQgjVAiXiG/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report. These aren't new issues as much as they are
Coverity now looking at FPGA code issues.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Thu, Jul 24, 2025 at 8:03=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 8
   - 3 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 8 of 8 defect(s)

Defect Details

** CID 583150:       Null pointer dereferences  (NULL_RETURNS)
/drivers/fpga/xilinx.c: 54           in fpga_loadbitstream()


___________________________________________________________________________=
__________________
*** CID 583150:         Null pointer dereferences  (NULL_RETURNS)
/drivers/fpga/xilinx.c: 54             in fpga_loadbitstream()
48     	xilinx_desc *xdesc;
49
50     	dataptr =3D (unsigned char *)fpgadata;
51     	/* Find out fpga_description */
52     	desc =3D fpga_validate(devnum, dataptr, 0);
53     	/* Assign xilinx device description */
>>>     CID 583150:         Null pointer dereferences  (NULL_RETURNS)
>>>     Dereferencing "desc", which is known to be "NULL".
54     	xdesc =3D desc->devdesc;
55
56     	/* skip the first bytes of the bitsteam, their meaning is unknown */
57     	length =3D (*dataptr << 8) + *(dataptr + 1);
58     	dataptr +=3D 2;
59     	dataptr +=3D length;

** CID 583149:       Control flow issues  (DEADCODE)
/drivers/fpga/ACEX1K.c: 226           in ACEX1K_ps_load()


___________________________________________________________________________=
__________________
*** CID 583149:         Control flow issues  (DEADCODE)
/drivers/fpga/ACEX1K.c: 226             in ACEX1K_ps_load()
220
221     #ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
222     		if (ret_val =3D=3D FPGA_SUCCESS) {
223     			puts ("Done.\n");
224     		}
225     		else {
>>>     CID 583149:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "puts("Fail.\n");".
226     			puts ("Fail.\n");
227     		}
228     #endif
229     	(*fn->post) (cookie);
230
231     	} else {

** CID 583148:       Control flow issues  (DEADCODE)
/drivers/fpga/cyclon2.c: 180           in CYC2_ps_load()


___________________________________________________________________________=
__________________
*** CID 583148:         Control flow issues  (DEADCODE)
/drivers/fpga/cyclon2.c: 180             in CYC2_ps_load()
174     		ret_val =3D FPGA_SUCCESS;
175
176     #ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
177     		if (ret_val =3D=3D FPGA_SUCCESS)
178     			puts("Done.\n");
179     		else
>>>     CID 583148:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "puts("Fail.\n");".
180     			puts("Fail.\n");
181     #endif
182
183     		/*
184     		 * Run the post configuration function if there is one.
185     		 */

** CID 583147:       Integer handling issues  (NEGATIVE_RETURNS)


___________________________________________________________________________=
__________________
*** CID 583147:         Integer handling issues  (NEGATIVE_RETURNS)
/cmd/fpga.c: 305             in do_fpga_loadmk()
299     #if defined(CONFIG_GZIP)
300     			ulong image_buf =3D image_get_data(hdr);
301     			ulong image_size =3D ~0UL;
302
303     			data =3D image_get_load(hdr);
304
>>>     CID 583147:         Integer handling issues  (NEGATIVE_RETURNS)
>>>     A negative constant "-1" is passed as an argument to a parameter th=
at cannot be negative.
305     			if (gunzip((void *)data, ~0U, (void *)image_buf,
306     				   &image_size) !=3D 0) {
307     				log_err("Gunzip error\n");
308     				return CMD_RET_FAILURE;
309     			}
310     			data_size =3D image_size;

** CID 583146:       Control flow issues  (DEADCODE)
/drivers/fpga/ivm_core.c: 1306           in ispVMDataCode()


___________________________________________________________________________=
__________________
*** CID 583146:         Control flow issues  (DEADCODE)
/drivers/fpga/ivm_core.c: 1306             in ispVMDataCode()
1300     		/*
1301     		 * Encountered invalid opcode.
1302     		 */
1303
1304     		return VME_INVALID_FILE;
1305     	} else {
>>>     CID 583146:         Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "return 0;".
1306     		return 0;
1307     	}
1308     }
1309
1310     /*
1311      *

** CID 583145:         (INTEGER_OVERFLOW)
/drivers/fpga/ivm_core.c: 1959           in ispVMBitShift()
/drivers/fpga/ivm_core.c: 1974           in ispVMBitShift()


___________________________________________________________________________=
__________________
*** CID 583145:           (INTEGER_OVERFLOW)
/drivers/fpga/ivm_core.c: 1959             in ispVMBitShift()
1953     		for (i =3D 0; i < size; i++) {
1954     			if (g_pucInData[i] !=3D 0) {
1955     				tmpbits =3D bits;
1956     				while (tmpbits > 0) {
1957     					g_pucInData[i] <<=3D 1;
1958     					if (g_pucInData[i] =3D=3D 0) {
>>>     CID 583145:           (INTEGER_OVERFLOW)
>>>     Expression "i--", where "i" is known to be equal to 0, underflows t=
he type of "i--", which is type "unsigned short".
1959     						i--;
1960     						g_pucInData[i] =3D 1;
1961     					}
1962     					tmpbits--;
1963     				}
1964     			}
/drivers/fpga/ivm_core.c: 1974             in ispVMBitShift()
1968     		for (i =3D 0; i < size; i++) {
1969     			if (g_pucInData[i] !=3D 0) {
1970     				tmpbits =3D bits;
1971     				while (tmpbits > 0) {
1972     					g_pucInData[i] >>=3D 1;
1973     					if (g_pucInData[i] =3D=3D 0) {
>>>     CID 583145:           (INTEGER_OVERFLOW)
>>>     Expression "i--", where "i" is known to be equal to 0, underflows t=
he type of "i--", which is type "unsigned short".
1974     						i--;
1975     						g_pucInData[i] =3D 8;
1976     					}
1977     					tmpbits--;
1978     				}
1979     			}

** CID 583144:       Null pointer dereferences  (FORWARD_NULL)
/drivers/fpga/ivm_core.c: 2406           in ispVMBypass()


___________________________________________________________________________=
__________________
*** CID 583144:         Null pointer dereferences  (FORWARD_NULL)
/drivers/fpga/ivm_core.c: 2406             in ispVMBypass()
2400
2401     	iSourceIndex =3D 0;
2402     	cBitState =3D 0;
2403     	for (iIndex =3D 0; iIndex < Bits - 1; iIndex++) {
2404     		/* Scan instruction or bypass register */
2405     		if (iIndex % 8 =3D=3D 0) {
>>>     CID 583144:         Null pointer dereferences  (FORWARD_NULL)
>>>     Dereferencing null pointer "pcSource".
2406     			cCurByte =3D pcSource[iSourceIndex++];
2407     		}
2408     		cBitState =3D (unsigned char) (((cCurByte << iIndex % 8) & 0x80)
2409     			? 0x01 : 0x00);
2410     		writePort(g_ucPinTDI, cBitState);
2411     		sclock();

** CID 583143:         (OVERRUN)
/drivers/fpga/ivm_core.c: 2455           in ispVMStateMachine()
/drivers/fpga/ivm_core.c: 2458           in ispVMStateMachine()


___________________________________________________________________________=
__________________
*** CID 583143:           (OVERRUN)
/drivers/fpga/ivm_core.c: 2455             in ispVMStateMachine()
2449     				 g_JTAGTransistions[cStateIndex].NextState)) {
2450     			break;
2451     		}
2452     	}
2453
2454     	g_cCurrentJTAGState =3D cNextJTAGState;
>>>     CID 583143:           (OVERRUN)
>>>     Overrunning array "g_JTAGTransistions" of 25 4-byte elements at ele=
ment index 25 (byte offset 103) using index "cStateIndex" (which evaluates =
to 25).
2455     	for (cPathIndex =3D 0;
2456     		cPathIndex < g_JTAGTransistions[cStateIndex].Pulses;
2457     		cPathIndex++) {
2458     		if ((g_JTAGTransistions[cStateIndex].Pattern << cPathIndex)
2459     			& 0x80) {
2460     			writePort(g_ucPinTMS, (unsigned char) 0x01);
/drivers/fpga/ivm_core.c: 2458             in ispVMStateMachine()
2452     	}
2453
2454     	g_cCurrentJTAGState =3D cNextJTAGState;
2455     	for (cPathIndex =3D 0;
2456     		cPathIndex < g_JTAGTransistions[cStateIndex].Pulses;
2457     		cPathIndex++) {
>>>     CID 583143:           (OVERRUN)
>>>     Overrunning array "g_JTAGTransistions" of 25 4-byte elements at ele=
ment index 25 (byte offset 103) using index "cStateIndex" (which evaluates =
to 25).
2458     		if ((g_JTAGTransistions[cStateIndex].Pattern << cPathIndex)
2459     			& 0x80) {
2460     			writePort(g_ucPinTMS, (unsigned char) 0x01);
2461     		} else {
2462     			writePort(g_ucPinTMS, (unsigned char) 0x00);
2463     		}



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--Fa5E/yQgjVAiXiG/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIOGDgAKCRAr4qD1Cr/k
CmXYAP9QOPVSsnxio8yJXkFO5pG6g48PagxP8Ug5xu7kSuaRPQEAhhSxjunsWwFv
0Y9jBMVy/Hcdx85oTbqBABS6ti4YPwc=
=N92t
-----END PGP SIGNATURE-----

--Fa5E/yQgjVAiXiG/--
