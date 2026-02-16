Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10B0E63F2A
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 05:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF7AD80FA1;
	Mon, 16 Feb 2026 06:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FHMlbwSA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BCIMk/M2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99E9083AA9; Mon, 16 Feb 2026 06:31:16 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2CDD8063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 06:31:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61FNLA322362055
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 05:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=PaxtY955xv7T/iclv5u7LIMd
 0iqbqY/SmuWyV37uTJM=; b=FHMlbwSAL0hdoSFlRY5dcSZp7zn6ka5aQ0BMmN96
 dY8t0hcLBVB3HxZUAHhsrZXt9gr8MhUy8W6fHOt6tafAMILsBXhlcGbB96KSsnhM
 Tyfw/dmvGOvAAFg9+XG3/KazEXwR53TgFwhLBpdLLu9IWb0iJpFyhGfwaUbnRedi
 eFtMvW8HgA8UnkqWddYK5khcy1/QJ1uEWKE8ytxX9EsBirzbfj6jJhCzkeW3KleX
 tOS9ivgTz17OsT729HLt7m+OCMYaX5IkRODrl8ZB1jOT6HY17u/Y+kPvfEILQ69K
 O4wi4kTqRrxGDqTWjWO0sa4rX4kUAvX+QP8eDSzglJ/JLQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cagcf3k9m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 05:31:11 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-824b461dc9dso6554171b3a.1
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 21:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1771219871; x=1771824671; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PaxtY955xv7T/iclv5u7LIMd0iqbqY/SmuWyV37uTJM=;
 b=BCIMk/M2/QMd17tEOYYU9koCWtYrII/jzEcLwelRGWBC1ZhhCcZUqwqnulBW6Uz+wb
 ZzNNBKZG+Dxhyrq8y9B3q0jn6FIPGgRgSBsuTmUUROuQMWVrvwwLC+534mQOANwKWpd7
 Vmo8xs1cZ79fH0yJfNeqMM859S+WS+aSHOpGXFgWVUDcVsjCfPI58GQgukNhiEMoXjWz
 RGJBMDzAjDKqDzHuW7Z977u8LLd4Saa3yl+1xlEeMRAWZ6lmWmMgFkiveC8cOdsgMBkm
 3/vi1QezgRCPuc+jUatpuFikfjkDtzGyzcdIFRGJ7pov0Asu4dEGEsIlOmZFO0FgB+3q
 XC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771219871; x=1771824671;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PaxtY955xv7T/iclv5u7LIMd0iqbqY/SmuWyV37uTJM=;
 b=a4J6WcaGQ0LGCEQu6FAGkfZt2REwHKOQhQ7E/Jfl/xMdqrPHVLpRc5bOhFfoPyvhPP
 4frYyvdiFvyUnGC78Q7Lg7I8MBcNSag6j9uUTA3s4w6QFHSbZj9upR+5gxrZOBl6gV15
 oNcgdLQEjtbY6Zvxb7XWbsL3JWyhPvU2nu7s/LPQGOVwnLdzwlY/cHDdZo4kN6yuj0vW
 3vpNDRPQSDjm9hV335pOi8DH/aA9mfe2Kb9mYk2OG8ut/+eLXJtlLIwu7NwBKfzWFXQj
 6JTJnobhItJhkHKTn+e48aHiFrNJx2Q4ItXAINCyqXU/8hQ/QmtMGQOMIZo8KyHShTF4
 PaUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGwtGIqLreZztrnI/LSaXkdQPzXfwG7SDLomHF9zXpJTW66BhhOIdQ91rnkFKW74VLqAWvqfA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw43BWJ9xTAZKoXR6N5Vybn3eQYNiueJRltal6VE4mfjnIkBTpe
 zCr2mBCyvpCujfNbwe5Gyw6yBL1p89nnHaYP55QYhbZRNVha0H9Tj3bA1rNlfafOe7iakcFfiAd
 9xdVaZ7QLNiW8XkvBmhgMlvkaO9WM+6145fDZrLl4XFHFz8pn1z3sOvPi
X-Gm-Gg: AZuq6aKd0b0ceP5MY+tff19BTKiUVdOugekG7H8meEiJ0/RUJqMl6oBvAJ++TzWibgL
 eme+LQkUk9nCfNmahsEFvzD+5bOd5v4NaBFYGOMeaIXZh+EZH/+JQVxowqo/DIQFbAFVYYaKlpO
 dbhODy00lL9vlZt4sT8TkfWKIdVosaBWQhaxUuzGKsG35W8Tu1O3XdbGd6r7VYLlZ1oCVvf3/Yi
 97AzIfVtjL7Ra14HjjjLT4/Xb9WJtz9KG8rZh/nRXgyXsHy72oG+x1263oLIxbbhYuc7Q2LfhU6
 mdWgM4ulCAACFbUG8jGF1wn6jwjFUpqxpZTfecvOmejbPDfTBb5ZnkZrDKELSRAf154j0MQ2nHV
 rk2VcZKDndx0sM8JDOMJ3kHpOB120LAiVk8IZCZ9iy8XoGEnrB/ymB9EeblDpn79KhoI9clWbIa
 1VwUq9EMHOl+wn3WRE4vFyzwxxOGgRehuDFhLveS4rPNJptMrykmI=
X-Received: by 2002:a05:6a00:1988:b0:81f:3ae9:3f71 with SMTP id
 d2e1a72fcca58-824c5f3a63dmr8744317b3a.28.1771219871049; 
 Sun, 15 Feb 2026 21:31:11 -0800 (PST)
X-Received: by 2002:a05:6a00:1988:b0:81f:3ae9:3f71 with SMTP id
 d2e1a72fcca58-824c5f3a63dmr8744289b3a.28.1771219870613; 
 Sun, 15 Feb 2026 21:31:10 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a4316fsm11693339b3a.23.2026.02.15.21.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 21:31:10 -0800 (PST)
Date: Mon, 16 Feb 2026 11:01:02 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 me@samcday.com, aswin.murugan@oss.qualcomm.com, clamor95@gmail.com,
 michal.simek@amd.com, u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/5] drivers: sysreset: Add sysreset op that can take
 arguments
Message-ID: <aZKrlhpNI/tpdWmG@hu-varada-blr.qualcomm.com>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-3-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszThUMWgySrb4H2F5PE6XVsRK0Cc+PZ37f_3xZ12HEhM=3g@mail.gmail.com>
 <aXg8ge6z7EMWliSd@hu-varada-blr.qualcomm.com>
 <CAFLszTh-B=zQyBjwJ_OuVxAbpTpUaKB1e9zB8Nm6+wuJCK5OcQ@mail.gmail.com>
 <aY7x9EAueKZ9Xxmt@hu-varada-blr.qualcomm.com>
 <CAFLszTgWW0-3hXkUWVmiDgfT1yMZMkjX8zDsT8Qf846ZgaA2Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgWW0-3hXkUWVmiDgfT1yMZMkjX8zDsT8Qf846ZgaA2Xg@mail.gmail.com>
X-Proofpoint-GUID: oojW1gz7aRZ28yAh1UNDDxubogFyiyqM
X-Proofpoint-ORIG-GUID: oojW1gz7aRZ28yAh1UNDDxubogFyiyqM
X-Authority-Analysis: v=2.4 cv=Sc76t/Ru c=1 sm=1 tr=0 ts=6992aba0 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=sIOAkJN-aCX8nIGTJ4YA:9 a=CjuIK1q_8ugA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA0NCBTYWx0ZWRfX47jH89yMeFUC
 QDTEUmQz+335fICjdROlgLYDnxNZIoCn8iFxRt02p06V/rO94E8YqKUkdWwVmGAyndVFBm1I+kw
 qG26HvSIbCdQqS5mRjsO4tnaU2U4JL1eLbQnjXHWKMKTpSqCi7fbatGCaOKkrLwskv/7tdAKZcK
 ZlyrXWMc76+vzGZsoOhbGa71NTtl4ruyfnF9Sry7uh5XAEj9HsAkogGap+Zjla9vhSOq7c1A8hT
 83j50zuMxsUVEMIVn9Vy3xMQJyJjMcRfpn8Y7bWHjGlm9hapqXhlp4v76yS3zG6H0YoUmqXfynC
 9No21ZVzRU3AYXK5U7Q4oqOUbd2w5UEcy9Z4HSfMJLqs7UDAZZXdZlYkR486EbIQExgtRNKQcDZ
 iPAnGk5oqWtFtkulvLLmCgkHVI3mJv/WXQWJbVny/vRabntCeF+Bcc6W4dix4IV7OZ6gIO2aQc4
 vCliOOVuygrfMU4U7OQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160044
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

On Fri, Feb 13, 2026 at 01:20:10PM -0700, Simon Glass wrote:
[ . . . ]

> > > > > I haven't been following this, but what sort of args are you planning to pass?
> > > >
> > > > As of now, an argument to indicate reboot to emergency download mode.
> > >
> > > So how about adding a struct in sysreset.h where you can include a
> > > flag word and create a single flag for your case? We should be able to
> > > handle reset without the cmdline being enabled.
> > >
> > > There are other cases where this would be useful, e.g. an EFI app
> > > rebooting into setup boot.
> >
> > Previously, i.e. v5 [1] didn't have SYSRESET_CMD_RESET_ARGS config
> > option. This was added to avoid bloat code size for platforms that will
> > not need this. Please see [2]
>
> Sure, but you are adding a new method, so you could make it take a new
> struct instead of the string list, still behind your Kconfig option.

Sure.

You want 'request_arg' function pointer to take a structure instead of
'char * const argv[]'. Is this understanding correct?

If yes, this string list is what was given in the command line. And is
passed to the implementation specific handler.

	Command line -> do_reset -> sysreset_walk_arg -> *request_arg

The implementation specific handler can interpret the argv[] as
applicable to itself. Not sure how to convert/parse this to a struct
that can be used by EFI app. Am I missing something. Please advice.

Thanks
Varada

> > 1 - https://lore.kernel.org/u-boot/20260113103840.1948029-3-varadarajan.narayanan@oss.qualcomm.com/
> > 2 - https://lore.kernel.org/u-boot/20260119170701.GD3416603@bill-the-cat/
