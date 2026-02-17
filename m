Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBFBE83848
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 04:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE52483AA9;
	Tue, 17 Feb 2026 05:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hZyl3OmP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N/Qv7Z7h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B675F83B8A; Tue, 17 Feb 2026 05:24:48 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C50983981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 05:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GL7e441613296
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 04:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=E37NV/kpiSlbmcyHh5XB7xwM
 cifR0EG1ClfbUXaD/b4=; b=hZyl3OmPUe1eBhkdjksUSnQZCKT7m7kA21tj5inq
 7k/lFB1HjxUMdv0GsIt7UVWWVt3WUc3nD87qhFvkQnzpKvgoLLnBTZLTbZq/5q9B
 JJVvYLh5XGekAgpVa6OgYT7KJ0VCGXuB9aLxpPQHShIKHl3ZJ9GRAL5ESSwpXUXX
 wOfiWZFsZI1M4k1WxCX1u+xuSgJ/axbfXR0Oz3cOpQPgcyTrUPqSE2OSfJOfXtvC
 vwJVDI5goONHUdPpZ/sZPofYsL0TUyBvmQvGOtTE/wyBcdzil7QJ7E/41QgCvkM2
 swFx9vJZmSZxj7ZpCAwJHXgZus28uWwcUipLF+2CSVTuwA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc662s6fw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 04:24:44 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a863be8508so41932735ad.2
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 20:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1771302284; x=1771907084; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E37NV/kpiSlbmcyHh5XB7xwMcifR0EG1ClfbUXaD/b4=;
 b=N/Qv7Z7hrIriS4b6QiOgbrH9qHVYVIXbBtIx+sxzrVtv7WzJDeAwHqgWmg4cP5Twme
 jVPLirMDBqkYP6AralTtBeJ+PNVupZnUIjphODdlIjqGoC8R4e0FUP57dTY77HVviCjS
 k3FjXswc0Radm0uwLUU1FIZl2zLbJKg/XnQ+BQ8DVtW3LxAjjTNjLbYS0cK1epwujrhA
 NCssh6fMmuIJWyto3Il917p3HLwegWSYvFP4ToyAGu0EXyp9nUQZLEwhwcIW0CRPdeVC
 707/2hRqEsfs6lvpTNWhe2oHG2dfrzpILK+wwdaLUH9qM7bx39RRDZNwupFnKgjKLo8H
 qz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771302284; x=1771907084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E37NV/kpiSlbmcyHh5XB7xwMcifR0EG1ClfbUXaD/b4=;
 b=PZ4K+3jfJW7xn8iBsaNRSaajRfdUsCt6Of17kw8UUtSuYpZ93p3wXoAoQRHXn3Ly99
 nLSvRl14xcZsTvpfT9sLG90H/Pdt6jTkHv4L7f6ZRgOymPw1fkS035KLWQaBklBn0hqf
 KTxA0Pka098f+hovKAV7ebEDY6FXQj0lYFDnJeWY179H7vtwaP3vRlJbeU08UFKG2MdN
 rCf6WxomSg2r2CZls1YLNT31QI1kqdNMGVK2LgR+NKADrzMR055Xv1aZA+YQgO7UrMRz
 +1iB2RgIjuptvfsg25eivZZHE5UgDN6jEWmUa0UqnXyvKP60nPuRPD0jA/gdILwl5u+q
 DVyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTKydEdL/aeiQQkRnpOus1GzJWqUTjgCXeoQmu4fgY6Srv3voaZqHS/PrLN/DKA1+lXK9ma1Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwaNRbpM5rr5ufcacR11A5LuUKSiyA2kawgMkOi9Q/0LHLHMTgd
 4ClYOSFdU9offJNNGBAnp9KaAoL2lKJlWmCABC6Qz0DTrOFZ4iT1/iaejJbtRvOoqoyZoe1IH1V
 E2QluC0Km132j+8ym+rkISl7L5hPUYeVJ3p3LtV30RrKeCJeO7Abn0Hfx
X-Gm-Gg: AZuq6aJzIf/XdxvZLzSSI84ldpQvrQc7FHXmh2kzwy2lvQBdoGiYT6rseaScgRRJXQ6
 HSrNeZU/j/91OXJz6JYjEUyP9PVxDvvspbZC/smzdcnUni2H9OAEv7EGBCJIiraQy/5rXSt4HWO
 bBJlDa6RMsPmLfghRJiqKyhNHJqpzkNHM4rRWW4tDbXEeU95Rdun9dQZi/q1cLmPIpV9N1c0e7V
 XZ9ZRxFFbk35X0uHyIVK3LMVrkTGYWEeyJ0xGteGy50b6Ya2uNfRDX1w+7py24arBC3eMIVM0jb
 N4KlY1aTgN+Wnia0dwKKkXOf+niWKRINHXudII5A4VaMeCKRzFUicViaUsM8AaERcf8jgXX14Gv
 M1PApNn0Km4MGTojId+NDZhQWFXuU3KDkBK9lRbE8Vr5MxNoLamctATbMXwZkD3RroxGTmkLyf3
 7XG/NBlIDNzJUHxmlvJwJLWCyo43JgSlNHzmpUMlZARtVPH1YATNw=
X-Received: by 2002:a17:903:8cb:b0:2a7:9163:8e68 with SMTP id
 d9443c01a7336-2ad17430143mr98718365ad.6.1771302283697; 
 Mon, 16 Feb 2026 20:24:43 -0800 (PST)
X-Received: by 2002:a17:903:8cb:b0:2a7:9163:8e68 with SMTP id
 d9443c01a7336-2ad17430143mr98718125ad.6.1771302283212; 
 Mon, 16 Feb 2026 20:24:43 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a6f9f9fsm79822965ad.6.2026.02.16.20.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 20:24:42 -0800 (PST)
Date: Tue, 17 Feb 2026 09:54:35 +0530
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
Message-ID: <aZPtg7dllBavk/a9@hu-varada-blr.qualcomm.com>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-3-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszThUMWgySrb4H2F5PE6XVsRK0Cc+PZ37f_3xZ12HEhM=3g@mail.gmail.com>
 <aXg8ge6z7EMWliSd@hu-varada-blr.qualcomm.com>
 <CAFLszTh-B=zQyBjwJ_OuVxAbpTpUaKB1e9zB8Nm6+wuJCK5OcQ@mail.gmail.com>
 <aY7x9EAueKZ9Xxmt@hu-varada-blr.qualcomm.com>
 <CAFLszTgWW0-3hXkUWVmiDgfT1yMZMkjX8zDsT8Qf846ZgaA2Xg@mail.gmail.com>
 <aZKrlhpNI/tpdWmG@hu-varada-blr.qualcomm.com>
 <CAFLszTjB5OsdDRbSg7nduFtxzUT0jesvA7+dtU+op=YwfV+jqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjB5OsdDRbSg7nduFtxzUT0jesvA7+dtU+op=YwfV+jqg@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDAzMyBTYWx0ZWRfX39bACiIJnLm1
 8I3/PrtwGYJ+e9sfKMCv99cUQJqh0CN2UpQ3ouVpTqFxnkZmAZdB1dnp0nw3dcBitppMNzPfQb7
 o1zd9LwIgeejGxwuBWjV9Mvio2ApT1o5pI0At5E2ekTclNfXwCi0rk7UjSDnPEispyNRfmtzs2E
 SPXmxhh6qtatSLr0AXLYjF0aWGobQSt9SvFD3hKHa/z85o8oriSnSjSnMx4UC6RinC4hTvlR6p+
 aUOS0lDc0Y0BmWccRBdycKQ/Rr0IyAAAHSlKhEqLDWUm7YHpCY5t/hxogmfEKzCew7TByl74pz9
 EijN/m8DYIC5ESiwUD12U/hz123mvVYqno9YoQFvM39tzrEHShkrSs3pD3cKgaOU225vHopW//S
 1GqC1j4uUNzLT2a/l+nB7ZlOh+Jr1bfgUpJksN67b4ItnqadsELwBpBFYJxZdUtNwzzoXZ+zJ2w
 ABFzuK6EijuuS/osYiA==
X-Authority-Analysis: v=2.4 cv=Y6b1cxeN c=1 sm=1 tr=0 ts=6993ed8c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=4TfslC9ojAEn7qGajW0A:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: anjNBwG3SEYFxM6g1_vt8G_b1DNEVJCr
X-Proofpoint-ORIG-GUID: anjNBwG3SEYFxM6g1_vt8G_b1DNEVJCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170033
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

On Mon, Feb 16, 2026 at 10:19:48AM -0700, Simon Glass wrote:
> Hi Varadarajan,
>
> On Sun, 15 Feb 2026 at 22:31, Varadarajan Narayanan
> <varadarajan.narayanan@oss.qualcomm.com> wrote:
> >
> > On Fri, Feb 13, 2026 at 01:20:10PM -0700, Simon Glass wrote:
> > [ . . . ]
> >
> > > > > > > I haven't been following this, but what sort of args are you planning to pass?
> > > > > >
> > > > > > As of now, an argument to indicate reboot to emergency download mode.
> > > > >
> > > > > So how about adding a struct in sysreset.h where you can include a
> > > > > flag word and create a single flag for your case? We should be able to
> > > > > handle reset without the cmdline being enabled.
> > > > >
> > > > > There are other cases where this would be useful, e.g. an EFI app
> > > > > rebooting into setup boot.
> > > >
> > > > Previously, i.e. v5 [1] didn't have SYSRESET_CMD_RESET_ARGS config
> > > > option. This was added to avoid bloat code size for platforms that will
> > > > not need this. Please see [2]
> > >
> > > Sure, but you are adding a new method, so you could make it take a new
> > > struct instead of the string list, still behind your Kconfig option.
> >
> > Sure.
> >
> > You want 'request_arg' function pointer to take a structure instead of
> > 'char * const argv[]'. Is this understanding correct?
> >
> > If yes, this string list is what was given in the command line. And is
> > passed to the implementation specific handler.
> >
> >         Command line -> do_reset -> sysreset_walk_arg -> *request_arg
> >
> > The implementation specific handler can interpret the argv[] as
> > applicable to itself. Not sure how to convert/parse this to a struct
> > that can be used by EFI app. Am I missing something. Please advice.
>
> Really I'm just trying to have it defined (in the uclass header) what
> the behaviour actually is. An arbitrary string list seems too
> open-ended, as well as being less efficient.
>
> So I am thinking you can add a struct, define and document the fields
> in it and then other people can use the same approach when they hit
> this problem. For example, with the existing request() method, we
> created an 'enum sysreset_t' to specify the reset type, rather than
> using a string arglist.

As I understand, sysreset_t has a bunch of reset modes that is
applicable to majority of the SoCs. However, this string approach is
to accomodate situations where we don't know what the possibilities are.

> String arglist is good for the cmdline but not for programmative code.

I'm not very familiar with EFI and EFI apps. Can't an EFI app use the
efi_reset_system_boottime() API with reset type as
EFI_RESET_PLATFORM_SPECIFIC? Presently, efi_reset_system_boottime()
invokes do_reset() with argc and argv as 0 and NULL respectively.

Instead, 'void *reset_data' can be cast to a struct that has int argc
and char *argv[] in efi_reset_system_boottime() and pass those values to
do_reset instead of 0 and NULL. Wouldn't this be usable for
programmative code?

Thanks
-Varada
