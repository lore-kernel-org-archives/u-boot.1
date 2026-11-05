Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CF606AA53
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oS/sB/tC;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=D/pCPpgq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 221F54085A;
	Thu,  5 Nov 2026 10:14:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4K2b7pPj8lrC; Thu,  5 Nov 2026 10:14:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F14114084F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793873677;
	b=L6LomHPqdDK+FrnfH8av/VaUHyuQ6ZGttCOorstXoIZp3flKiBCeokHBtvkKTD66QHm9
	 OiLxz1lizez540JE1n5U6K1Rw3zYPLEUazFsvmocUfT6tdq2gZMYidmIoTm5plckru3ng
	 oK39ogo68hy+CywM659q0Eg8WFOp29gQ4zHftXPz4hlQvS+4FdIDv0qftRbAliMSVh7wB
	 i/9J/IFfn7PnRhdv89c4IRdaZQmk+wwN8qEjRAqbLpi01cYw0OZAqfzRrDenCe4x0UKKV
	 MXIh2uczmlV+Y0oIETTUm/4fEWIlsL4xs/PeS9Zd4GerPVFGAo9viOIcIxlFj1xI6Eg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793873677;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=umzqxmMQofijHh4bK3YVB9mRMK0sgfN6hFwBMe7rgnE=;
	b=DnIIltPKjq6oIBz+k6BCSkgqAd5sxxq43fIH73pWWp590MjOWqPKTQ6nOPJJj8xC3eC5
	 fiqkfZFEpTimKKMIAPy372ASk7DdhKZ2P+ssm9BLemPK2lDeL8SbeCLLZB8xBxEbJh89X
	 4yabn2LhziM2Sawln29S28WVFFeifiT6MhkpEcvoBG2vGMoLvypOEC+J8E0J1O9HbljH5
	 owgnwP/zi68O294dXUUOin0iSm8cMxI5wR0QloqJ2upQgd8xdzbmOj5c3U8rChQ8Aj2nf
	 QHpvGmxFNwwzSH/EQQL1zlHwow+LGHu08pzGJTsEvzXl8ZEKvEtks/BjxMcQwR8t6Tw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793873677;
	bh=umzqxmMQofijHh4bK3YVB9mRMK0sgfN6hFwBMe7rgnE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oS/sB/tCsLJrKtwLGdasXfh8DrR3+ZvDeO+fJkgpkb9osvYVpOQmcLUEsOou6c1xt
	 6OzFNOkmPArDqxLN/8j9RSGAustcQHhFpKCfwMOJcGCSbfavKq65le2VmF3hDS5bvH
	 ChmttSY5lB1j+tfzWUcVfLd+DoeuYY4n2xJIHJ0jZqMsgS+o7R84MDanXxd8ySpEeJ
	 eMPjm63JiXuBkhuWX3Nt00eWOUcllQvahIkvjtE4wL8cI4NA0PRnt+WyXWPJkXU/+G
	 U88KnIBzAbqrZxeIqTowY7OIhFokxjHts5erEvbU8zxUYVMJYLSorS+7lyTKaWC+AU
	 dj8wFCJWTWP8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F14114084F;
	Thu,  5 Nov 2026 10:14:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 92642177B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8FE6A6080C
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:14:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6K7-sThdLk9r for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 10:14:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3F10D605B5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=D/pCPpgq
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F10D605B5
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:14:33 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8b0d91601bdso3595077b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 02:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793873672; x=1794478472;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=umzqxmMQofijHh4bK3YVB9mRMK0sgfN6hFwBMe7rgnE=;
 b=D/pCPpgq64EinotV5BfPMlG00vX68I5NcUvOdO7Nu6NtZkZYenUW6h6iuZUn7VGX4H
 fU51rvlbSVn9SOO7w4VBBV4m41iWBD0Qfs9DBnJ18GihysHbygqqKiZwfoS4/sSrDFbe
 W51O2uRjEXxV3NN4EE2eILAqb+IirYkS6LI2xhbkftEU0ZkwFbWdHUiQq6AChHADnpHM
 7H2rQub7TtsGY6pEdMwjHtYsHb6ADFWE7sVJ8ihfQ/D2EGM/GcAUQypekYy9Zd6jwKIt
 QJYTmGn5LxiKujP3lOGL3ptVmXtOkZ0Ud4ONXUci5kBO/lF0s8dC8kVWNk64aZ9+rabA
 unKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793873672; x=1794478472;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=umzqxmMQofijHh4bK3YVB9mRMK0sgfN6hFwBMe7rgnE=;
 b=wF3+zmxzFixox+jiYFmIbhmbg/Yoqo3zhzDxyRC3JUqX8ClQftHYeE7kQ8Pcn7eUgj
 t/aFhTza333MKRkUWwwRVEEmLtc7GnmyTXny2/ZdP8UvKrdkTNc5/+yNocHnpMXpXix6
 A0djAGMKM/jggj8HRBhq77nn45Oz8to8T+Rj+G6QIIXvy2ysI4fQIbkVj0qsTdABw4Fs
 Q4JsP/UDgJQygjOuciNFsyzL5nHLbFkMn2294EkTR7EECpHrGqB9KwUf2N8K6WIDLaH0
 wb+j5TVdUv3lUqRet0HOE6/TREzuj1WUUCkAqXz8FsKRJsjVP34B4VqEuT1p9iL4sgOH
 HM+w==
X-Gm-Message-State: APuU4Z+zINcAwEy7EIxXoRvxd+LX4Ze0PDvVVrBLF9W8pw6NDm1DG650
 wZLcYQjBCz1NwpYtYtHb1rfZXGmsCLXPAdD2tK544eiEP+PzkkXnntXvs6XkYnuOT0G3j+CDwxM
 U0wZqFHzjmnQzgTFsJfLrY/bE0KWqJCKWeGVOAfykMfv30wxSD1l2LN8=
X-Gm-Gg: AYBFou2LZ2wiLctgQQHtsoMpBd2W+5XKGmF7DVDhALgnHvA9OkOtvxUzszFadZMqsxD
 rFlHs87rJP5i4niDqjOYWJrPjB41yMU1OhudzEVqY1Q8Ls0yoOxvewD53zz6yuddjkoSSmpatsV
 u07FrJZ5PLlpvkspTdTJh+SWwAqIWZT9sZXJuufxVKCf+zNeimj0ipbJVqKXTOhUNzVtUBorQUx
 L/lq78BaeiJ9nxzmoW4xuhQmwWc5QuVOPWP9q8oNoO3Be0FZk4ka0RBwxxDm028pQBfeZys67py
 BwImomvW9itNhXmSlIzg0iRdvb7V9HcbXLXXr+t9PJfup35diNzOpbaGtQIBx73sstaNlDkWK/Y
 BGrEJjg1SD3Hay4VhCwRbDDLGhiKy3yifsNxGu5PjbLoMQqtwix0DoJH0xPZSoVYLN7gpzNhwrb
 o2TtZpbbZSD6PcPw674aXhcx1mq+a+E9Z5Knemi2RE7E+oUB2VdIvAlLwuRB530/LAtDw85ltdD
 spDqqIyvS/IfmVtrsOOhD1FFqtn7nG7vWZQTZ1H6khkYhfXLbKrJUam8LVKhEndLlGiz4xMwHnl
 QIf10HSF4E06eUxjdLwzcv227Xae9Px1kqpxbKWikH7aR7orTnhkDYi05onLAb4oLWLuj/50z3a
 DH1AhLqEOcAZ7n0Heq1FU1KyZsTru4vA9XrDoVkBBwRsuAIfyE3IRmg7FvgMz/BTRsrRJsvy2Ye
 7t2x+kxS426UH6ab2Y/Doot1z7sWmX3PFZp2s=
X-Received: by 2002:a05:690c:e3e7:b0:8aa:e4e7:c5a with SMTP id
 00721157ae682-8b328c4108emr14232377b3.5.1793873671937; Thu, 05 Nov 2026
 02:14:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104094238.519111-1-tkirchner@emlix.com>
 <CAC_iWj+5qjivBQYL_3-J9P7AU7fqMky_GuWn4+48RaaNhT-Jeg@mail.gmail.com>
 <8d672101-07e6-4f6c-b15a-53973d58c34a@emlix.com>
In-Reply-To: <8d672101-07e6-4f6c-b15a-53973d58c34a@emlix.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 5 Nov 2026 12:13:55 +0200
X-Gm-Features: AclHuK-BEEME3pgHsQAACTNQADSBqo530QNb-gXJlMoAT6gmoMTdMAPIF87YlXM
Message-ID: <CAC_iWjKB0XTTcDqZD8KHR_-Ft61CuPUBvu29erOw=V2rzbGroQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] tpm: fix handling of PCR banks unsupported by
 U-Boot
To: Tycho Kirchner <tkirchner@emlix.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 11:39, Tycho Kirchner <tkirchner@emlix.com> wrote:
>
> Hi Ilias,
>
> Am 05.11.26 um 10:35 schrieb Ilias Apalodimas:
> >
> > Thanks for the update. You havent appended any of my reviewed-by on
> > previous patches.
> > I think this looks good overall now. Can you send a v3 with my tags?
>
> Sorry for that. As this is the first time I submit to u-boot I'm am not
> so much into it yet (;

No worries. It just makes our lives a lot easier.

Thanks
/Ilias
>
> Going to send the v3 soon!
>
> Best Regards, Tycho
>
>
> >
> > On Wed, 4 Nov 2026 at 11:42, Tycho Kirchner <tkirchner@emlix.com> wrote=
:
> >>
> >> A TPM implementing more PCR banks than U-Boot knows algorithms for is
> >> currently rejected by tpm2_get_pcr_info(), even if the unknown banks
> >> are inactive. Ours implements six banks, including SHA3-384:
> >>
> >>   tpm2_get_pcr_info: too many pcrs: 6
> >>
> >> Once this limit is lifted (patch 2), the existing code for deactivatin=
g
> >> unsupported banks with CONFIG_TPM_PCR_ALLOCATE turns out not to work:
> >>
> >> - the result of TPM2_PCR_Allocate (allocationSuccess) is ignored, so a
> >>   refused allocation goes unnoticed (patch 1)
> >> - active banks with algorithms not listed in hash_algo_list at all are
> >>   never detected (patch 3)
> >> - the fallback in tpm2_pcr_extend() deactivates *all* banks and does n=
ot
> >>   reset the board (patch 4)
> >>
> >> Patch 5 deactivates the unsupported banks in tpm2_startup() already, i=
f
> >> the TPM is actually started there, so that this happens before anythin=
g
> >> gets measured, also for users which do not go through
> >> tcg2_measurement_init() or the EFI TCG2 protocol. Note that with
> >> CONFIG_TPM_PCR_ALLOCATE enabled, this lets tpm2_startup() fail if the
> >> unsupported banks cannot be deactivated. The rationale is that enablin=
g
> >> the option asks U-Boot to manage the banks, so failing early seems
> >> preferable to failing at the first PCR extend.
> >>
> >> Tested on a downstream U-Boot based on v2025.04 with a TPM implementin=
g
> >> six PCR banks, with the unsupported banks both inactive and active.
> >> Build- and unit-tested (ut dm tpm, ut lib) on sandbox against main.
> >>
> >> Changes in v2:
> >> - 5/5: deactivate the unsupported banks in tpm2_startup() instead of
> >>   tpm2_auto_start(), and only if TPM2_Startup(TPM2_SU_CLEAR) succeeded=
,
> >>   i.e. not if an earlier boot stage already started the TPM, and not
> >>   for TPM2_SU_STATE (Ilias)
> >> - rebased onto current main
> >>
> >> v1: https://lore.kernel.org/u-boot/20261029150906.1558380-1-tkirchner@=
emlix.com/
> >>
> >> Tycho Kirchner (5):
> >>   tpm: check allocationSuccess of TPM2_PCR_Allocate
> >>   tpm: allow TPMs with more banks than U-Boot knows algorithms for
> >>   tpm: detect active banks with algorithms unknown to U-Boot
> >>   tpm: deactivate only unsupported banks before PCR extend
> >>   tpm: deactivate unsupported banks in tpm2_startup()
> >>
> >>  lib/tpm-v2.c | 76 ++++++++++++++++++++++++++++++++++++++++++++-------=
-
> >>  1 file changed, 65 insertions(+), 11 deletions(-)
> >>
> >> --
> >> 2.47.3
> >>
>
> --
> M.Sc. Tycho Kirchner
>
> emlix GmbH
> Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
> Phone +49 (0)551 30664-0, e-mail info@emlix.com
> District Court of G=C3=B6ttingen, Registry Number HR B 3160
> Managing Directors: Heike Jordan, Dr. Uwe Kracke
> VAT ID No. DE 205 198 055
> Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
> Office Bonn: Bachstr. 6, 53115 Bonn, Germany
> Office M=C3=BCnchen: Am Knie 16, 81241 M=C3=BCnchen, Germany
> http://www.emlix.com
>
> emlix - your embedded Linux partner
>
