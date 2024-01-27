Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9DBC46CD2
	for <u-boot@archiver.kernel.org>; Sat, 27 Jan 2024 20:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47A1C88015;
	Sat, 27 Jan 2024 21:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GwyscsOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D3DA88016; Sat, 27 Jan 2024 21:56:09 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9340988010
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 21:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706388964; x=1706993764; i=xypron.glpk@gmx.de;
 bh=J8KffdsJ/DFd5T3HnQIWn/rqrnnpK2xYId4zEbuXpMA=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=GwyscsOtSsGmob7PDRRvesmS9fXuy9JajSoFhmMpFfELXwCOycQPTAiM6HX19i6E
 cZmFgnc3uj4AdFRtHrIyV2DVyhK8f8Pqi1xbihWFW1idgxSLLqzS2646VcnvWEmne
 KxvCQl7deUvXs9jilc0JReVLLk7d57OIiVCEdem/7O4Z+EFCBTWlNYkho9Pxv2TUa
 ZwCLCTMUHRKjlSg60AgkkwupwQj9XtqYiIc+9uRg8x0cDte0Vz9mdN2uteKp9FBma
 m87JLhZkc2dKLTTIPZrRnASGHsy7dT1ee5yU1c42qF9ddUwyA37lpbZGdAHR6YAsZ
 OsVmFGW1Vg/YGJukYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mdvqg-1quDic1gzW-00b1oS; Sat, 27
 Jan 2024 21:56:04 +0100
Date: Sat, 27 Jan 2024 21:56:03 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
User-Agent: K-9 Mail for Android
In-Reply-To: <20240127154018.GC785631@bill-the-cat>
References: <20240127154018.GC785631@bill-the-cat>
Message-ID: <70BB005F-709B-4B50-AFDB-85EAD7BFC5E8@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PvfGZgqmaK8/fvXqM4r0ZPZcQo57+YlLXR5UqN2TLdsUoZt7Swl
 X4tlQU8z+g8embuYsnIc0OmkeuEg8nBp/ZJjZYFoKBWpYjj9sxip7sdt7qZPYkaCXGSWsl9
 MCxdjrheFNawjMl4HfKWSUXZwyi+WYLiX5O4u2fHafqMH9umyigDJ24VhPsKl/+tf5Uf41H
 JFWx94+BN6wb7oQYdutBQ==
UI-OutboundReport: notjunk:1;M01:P0:wnuC9nqDlJU=;bji8nSRJ93PcG03GmUOcfLRhGBC
 Wh1ZCkUR2uBh+QJoMddYXwZUBEEEzS0wlvfGyVjbd/OQA5CGBgIt0yMjFRmRHh2qWK7z4vhGE
 W7CM6D0XFTzIDA+eAArK2NFXwK8LxA1bCEOlMrU7mZ/97YNcblpj4L8f4nRykljWyDyB2VbpE
 /HDCf0JPajO/2JyG6TqWRoB0W7RFXt4KOKBcQJee9IBl5Nf6SywvUiWEJ6zfOchttAyhu9Xie
 vZ7td/ikUXQRnCnOIre2XSUNXxdereUPZAd7cVvNUHmIkHVXjtSiiyDaHpl0TF/TSH/bedVuh
 BGTWXOlnQCntIow/cbHfsi4mhtJcyNovJ5snyOCP2NkbpUZjzhVLPQU9DKXqk4ZmFODxhPXIj
 NBjlxGZI4LN6rvygjeVoDfUNnfLu4am3NogGRb3dDfcqsTQfhqdVyV1ArwZQm2faRTgz3kKHD
 Nb586xcMG3I6u3zKQyMYLjNd47tCs2yM/D8YVIV8YtbDfMMoiyHozwOT5krBm4Hwql31PmKhw
 Lwjk6jEKV8zySUmSuLvdumFhkFrZ1bNGROgZ+F/BcK3soVxTCfPe1mgEp1rESfKBucPaVsRWj
 4B6ooX7muSOMh/mtqtHSDYfaG+NYXJX98fsZ+qg/aoXw9eHtaLYEHhzycSq1/vIHDAobk6AcU
 RpJO4BSnQ/hyjSkt1AqwGfwVqhX9bv7VfpYUsB76KZNr+3QOul6/W7f4nblwvxUShT2JA85W8
 6Jbx1LL0uKQDWs/s6dTGTX4b2Dj4SdcnlqMpmLnAX/RgoNFCfhuz+h6W71ALDM15HUO6OpgTN
 t1hwzNP21e7GebGE3Wjzb+Dv/tk60/AcuKXFzwhg0wN4nIReP3NfujU7THQr3vmnf5C879W3W
 7hJEWyasSMnr6iLmyrJJMwGWNO2cQ9/69cqTeZgE+e0Yema0z+1Csyj9lkV+UdPH/rKRg3/tN
 Y4628hCUgRB2ZrArmMDyY4NKzPM=
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



Am 27=2E Januar 2024 16:40:18 MEZ schrieb Tom Rini <trini@konsulko=2Ecom>:
>Hey, I'll just pass this on directly rather than to the list=2E
>
>---------- Forwarded message ---------
>From: <scan-admin@coverity=2Ecom>
>Date: Sat, Jan 27, 2024 at 10:36=E2=80=AFAM
>Subject: New Defects reported by Coverity Scan for Das U-Boot
>To: <tom=2Erini@gmail=2Ecom>
>
>
>Hi,
>
>Please find the latest report on new defect(s) introduced to Das
>U-Boot found with Coverity Scan=2E
>
>1 new defect(s) introduced to Das U-Boot found with Coverity Scan=2E
>
>
>New defect(s) Reported-by: Coverity Scan
>Showing 1 of 1 defect(s)
>
>
>** CID 479279:    (TAINTED_SCALAR)
>
>
>_________________________________________________________________________=
_______________________________
>*** CID 479279:    (TAINTED_SCALAR)
>/cmd/smbios=2Ec: 180 in do_smbios()
>174                             smbios_print_type2((struct smbios_type2 *=
)pos);
>175                             break;
>176                     case 127:
>177                             smbios_print_type127((struct
>smbios_type127 *)pos);
>178                             break;
>179                     default:
>>>>     CID 479279:    (TAINTED_SCALAR)
>>>>     Passing tainted expression "pos->length" to "smbios_print_generic=
", which uses it as a loop boundary=2E
>180                             smbios_print_generic(pos);
>181                             break;
>182                     }
>183             }
>184
>185             return CMD_RET_SUCCESS;
>/cmd/smbios=2Ec: 154 in do_smbios()
>148                     size =3D entry2->length;
>149                     max_struct_size =3D entry2->max_struct_size;
>150             } else {
>151                     log_err("Unknown SMBIOS anchor format\n");
>152                     return CMD_RET_FAILURE;
>153             }
>>>>     CID 479279:    (TAINTED_SCALAR)
>>>>     Passing tainted expression "size" to "table_compute_checksum", wh=
ich uses it as a loop boundary=2E
>154             if (table_compute_checksum(entry, size)) {
>155                     log_err("Invalid anchor checksum\n");
>156                     return CMD_RET_FAILURE;
>157             }
>158             printf("SMBIOS %s present=2E\n", version);
>159
>/cmd/smbios=2Ec: 174 in do_smbios()
>168                            (unsigned long long)map_to_sysmem(pos));
>169                     switch (pos->type) {
>170                     case 1:
>171                             smbios_print_type1((struct smbios_type1 *=
)pos);
>172                             break;
>173                     case 2:
>>>>     CID 479279:    (TAINTED_SCALAR)
>>>>     Passing tainted expression "((struct smbios_type2 *)pos)->number_=
contained_objects" to "smbios_print_type2", which uses it as a loop boundar=
y=2E
>174                             smbios_print_type2((struct smbios_type2 *=
)pos);
>175                             break;
>176                     case 127:
>177                             smbios_print_type127((struct
>smbios_type127 *)pos);
>178                             break;
>179                     default:
>/cmd/smbios=2Ec: 154 in do_smbios()
>148                     size =3D entry2->length;
>149                     max_struct_size =3D entry2->max_struct_size;
>150             } else {
>151                     log_err("Unknown SMBIOS anchor format\n");
>152                     return CMD_RET_FAILURE;
>153             }
>>>>     CID 479279:    (TAINTED_SCALAR)
>>>>     Passing tainted expression "size" to "table_compute_checksum", wh=
ich uses it as a loop boundary=2E
>154             if (table_compute_checksum(entry, size)) {
>155                     log_err("Invalid anchor checksum\n");
>156                     return CMD_RET_FAILURE;
>157             }
>158             printf("SMBIOS %s present=2E\n", version);
>159
>/cmd/smbios=2Ec: 180 in do_smbios()
>174                             smbios_print_type2((struct smbios_type2 *=
)pos);
>175                             break;
>176                     case 127:
>177                             smbios_print_type127((struct
>smbios_type127 *)pos);
>178                             break;
>179                     default:
>>>>     CID 479279:    (TAINTED_SCALAR)
>>>>     Passing tainted expression "pos->length" to "smbios_print_generic=
", which uses it as a loop boundary=2E
>180                             smbios_print_generic(pos);
>181                             break;
>182                     }
>183             }
>184
>185             return CMD_RET_SUCCESS;
>/cmd/smbios=2Ec: 174 in do_smbios()
>168                            (unsigned long long)map_to_sysmem(pos));
>169                     switch (pos->type) {
>170                     case 1:
>171                             smbios_print_type1((struct smbios_type1 *=
)pos);
>172                             break;
>173                     case 2:
>>>>     CID 479279:    (TAINTED_SCALAR)
>>>>     Passing tainted expression "((struct smbios_type2 *)pos)->number_=
contained_objects" to "smbios_print_type2", which uses it as a loop boundar=
y=2E
>174                             smbios_print_type2((struct smbios_type2 *=
)pos);
>175                             break;
>176                     case 127:
>177                             smbios_print_type127((struct
>smbios_type127 *)pos);
>178                             break;
>179                     default:
>/cmd/smbios=2Ec: 174 in do_smbios()
>168                            (unsigned long long)map_to_sysmem(pos));
>169                     switch (pos->type) {
>170                     case 1:
>171                             smbios_print_type1((struct smbios_type1 *=
)pos);
>172                             break;
>173                     case 2:
>>>>     CID 479279:    (TAINTED_SCALAR)
>>>>     Passing tainted expression "((struct smbios_type2 *)pos)->number_=
contained_objects" to "smbios_print_type2", which uses it as a loop boundar=
y=2E
>174                             smbios_print_type2((struct smbios_type2 *=
)pos);
>175                             break;
>176                     case 127:
>177                             smbios_print_type127((struct
>smbios_type127 *)pos);
>178                             break;
>179                     default:
>/cmd/smbios=2Ec: 180 in do_smbios()
>174                             smbios_print_type2((struct smbios_type2 *=
)pos);
>175                             break;
>176                     case 127:
>177                             smbios_print_type127((struct
>smbios_type127 *)pos);
>178                             break;
>179                     default:
>>>>     CID 479279:    (TAINTED_SCALAR)
>>>>     Passing tainted expression "pos->length" to "smbios_print_generic=
", which uses it as a loop boundary=2E
>180                             smbios_print_generic(pos);
>181                             break;
>182                     }
>183             }
>184
>185             return CMD_RET_SUCCESS;
>/cmd/smbios=2Ec: 180 in do_smbios()
>174                             smbios_print_type2((struct smbios_type2 *=
)pos);
>175                             break;
>176                     case 127:
>177                             smbios_print_type127((struct
>smbios_type127 *)pos);
>178                             break;
>179                     default:
>>>>     CID 479279:    (TAINTED_SCALAR)
>>>>     Passing tainted expression "pos->length" to "smbios_print_generic=
", which uses it as a loop boundary=2E
>180                             smbios_print_generic(pos);
>181                             break;
>182                     }
>183             }
>184
>185             return CMD_RET_SUCCESS;
>/cmd/smbios=2Ec: 174 in do_smbios()
>168                            (unsigned long long)map_to_sysmem(pos));
>169                     switch (pos->type) {
>170                     case 1:
>171                             smbios_print_type1((struct smbios_type1 *=
)pos);
>172                             break;
>173                     case 2:
>>>>     CID 479279:    (TAINTED_SCALAR)
>>>>     Passing tainted expression "((struct smbios_type2 *)pos)->number_=
contained_objects" to "smbios_print_type2", which uses it as a loop boundar=
y=2E
>174                             smbios_print_type2((struct smbios_type2 *=
)pos);
>175                             break;
>176                     case 127:
>177                             smbios_print_type127((struct
>smbios_type127 *)pos);
>178                             break;
>179                     default:
>/cmd/smbios=2Ec: 180 in do_smbios()
>174                             smbios_print_type2((struct smbios_type2 *=
)pos);
>175                             break;
>176                     case 127:
>177                             smbios_print_type127((struct
>smbios_type127 *)pos);
>178                             break;
>179                     default:
>>>>     CID 479279:    (TAINTED_SCALAR)
>>>>     Passing tainted expression "pos->length" to "smbios_print_generic=
", which uses it as a loop boundary=2E
>180                             smbios_print_generic(pos);
>181                             break;
>182                     }
>183             }
>184
>185             return CMD_RET_SUCCESS;
>/cmd/smbios=2Ec: 174 in do_smbios()
>168                            (unsigned long long)map_to_sysmem(pos));
>169                     switch (pos->type) {
>170                     case 1:
>171                             smbios_print_type1((struct smbios_type1 *=
)pos);
>172                             break;
>173                     case 2:
>>>>     CID 479279:    (TAINTED_SCALAR)
>>>>     Passing tainted expression "((struct smbios_type2 *)pos)->number_=
contained_objects" to "smbios_print_type2", which uses it as a loop boundar=
y=2E
>174                             smbios_print_type2((struct smbios_type2 *=
)pos);
>175                             break;
>176                     case 127:
>177                             smbios_print_type127((struct
>smbios_type127 *)pos);
>178                             break;
>179                     default:
>

The values may come from QEMU, so may be "tainted"=2E We could check the l=
ength of the individual structures against the total size of the SMBIOS tab=
le=2E

Best regards

Heinrich
