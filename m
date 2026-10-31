Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F33606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eBPvT5N/;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BnzKcs2I
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 114C540B33;
	Sat, 31 Oct 2026 09:29:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ufsnpo4yf3HX; Sat, 31 Oct 2026 09:29:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5418140AE1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793438997;
	b=WdGvY+wRDRHIp+TtxMmsiDVZGCBJh74sAd0K9i0au3Dc5Zolif3RiUjDHk6Fc0XV/O5k
	 vzegUK+meat2n7tKO3kL5O1+93jJxUkMsXK7Nvq6QvicjQqPjzGiFSBbvIYu4elvoj51A
	 j5vt2PP1G0QEpElod37EdCBOaf1pR2F3PKd6XLV43wyRNI0Bjv8Cg/lOGKGZS2BKTB+nY
	 3Iifm1tDj4Hr12EiQ2neOI3yW21Tc21D7QiyMl9uZF81Kj+fXf96WVQqdyfAjsaYo3LuI
	 XlaC0/xPrXlKfexRttuCcxl9Kz2POsMRh8dUrsgRmdNTaWgYGkTlR8ZNvA4gTpn0O8g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793438997;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UNI0f/x+A3VFfyuWNL93KS553nptZeSA3sVd8g/VcJE=;
	b=E9H4tO0SBX/gEjhcKV+M1oS3bcFiASl5a7GetxypYgjfIldSqsOvWWIqK/0FZEYS8phH
	 lXMve38xecgeFYmeRPlUjc6Bc/S9cW3rqJfjISvy0yuPp3iJqIv/fW/cWpqL28aToBzXa
	 kUtJBfB1OX6VhajYu/bHi2BoMUzUqke8ugrgL+GEIcquQO2n9Fi5OviX1RpB4tOi35nOl
	 m8QmwmCZZjcxzg0ktbVJPLbNTMcxpb4wWSwpG4Q8pD187PUG/FvHnhPdmSlEedEOeNz68
	 oi8xXfBQz6DlkmT0ipVXaKohzec+DcYmpooIB++slHrGJPjRo5+a9fDYG6VkbXUxHRg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BnzKcs2I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793438997;
	bh=UNI0f/x+A3VFfyuWNL93KS553nptZeSA3sVd8g/VcJE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eBPvT5N/xLPTYWYn7OGdJ0VE88gjKRUiYG3obMqobf1b+P9wy3vlcoOPAPnOeyVZL
	 rnVKZj/t9hH6O6KSgRVXAHNp07XtCuuKOMvnuiti4il/3Jy621pFcg/gA+OsHuO6qh
	 UOhuXvOth+OL/ZUZEPzG4JXR7wEYVnN8fgYvpJCy+4PgV9JU1W/GdNGra7BfTBT/tL
	 /VqjQqKwJYiQWrx1FhBSJVNCPQ0V/VQ0lsLH+14Q1vY2jUkhq+BP0osYF74xBPT5b9
	 VhGTftT6WihUBk0mpTuZ8PKdxIF7iH6QxR1X5jNVXWde4yits099Y0sP/d0YpXxSBL
	 tf5SOqH/dMIrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5418140AE1;
	Sat, 31 Oct 2026 09:29:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 230D8362
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14A6040B34
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:29:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qM0K1ixUWovs for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:29:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4EC4240AE1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793438990;
 b=ibjzBkDkJG2DVSR8ny8glsZ5GEu2ZKw9VLX12lsKdoHJfUcERT+uojxqZ3DFMuIVuNKp
 abnF7tlozGkEevqD+RThYMHttEd7R/cfbtLBgVR6ZuUlsCnMd+ByawecOuQ194uVsQNNp
 W37IJPYi+Xt8ia6HF2qZ4BAda9flNh0jNc2oagKTzeRq/Bz3rO4uXpZyFybNsR5aPOj6N
 YFsS+aKyD2z4MBBgf6jwUbVR9amhex2RmgimixppNN8d0Cmuw7HNxhXDwGnmG/6N9TzUP
 EgoPahVMTpJvsAtVYm+eS8IgsG5nSUa3gAPbwuBxw9kQnCar2mGBfXNDoQI46zieI/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793438990;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=UNI0f/x+A3VFfyuWNL93KS553nptZeSA3sVd8g/VcJE=;
 b=skBIjyrrGQIJpPpPrHJV9s4oTqjEDyOON2ast9HPXsBUAQsM9DLBACa5y9lFTlvbk8ph
 TTvILV+BtsjeTu6/7UaAR/F9m33li2mUufPL0jm7Ypm+dlm5QHSg3x+40D191yPj8blQ7
 FIDEhAMTh8JN5pLJl4SeBSIiNawWaD6GOg80hsN3LYNBHNL3lr6VZvOFOkXgNgPczX+GL
 IJ1TZSm7godBzrVB9sIrft/Sx1yjrDoH0C1YpdwLsOAPzs+Lkj66/RQ6Hh2o0QYw544hu
 7LtMSX/zWLw9U8cKemqR6PyzpTfnBjP+MQ+mMJhDRN3+ZUtCkGO+YG7mY75Em9HvwUw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BnzKcs2I; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=BnzKcs2I
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4EC4240AE1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:29:49 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cd5cd8d89a7so647962a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:29:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793438989; cv=none;
 d=google.com; s=arc-20260327;
 b=k9WL7BP4zsg1Vyd6RNaoAMkhziPBI+I9bw45Z7BrSPrC7dliHV81nG8/XnDyWj8aUm
 aJiw0cYzaPKqm+ibbuS0cy0TWtHEdY99ENGWxeFDGVy83eKyB4VmGLA7fiPKgldCd4Kt
 iC/JfSTLrYEhAA3YEsNT19UKgc+s0OInQm9Ay5snc9+BLK27OP3mZacnnUA5ebYy/AzA
 VGdaSj71tbJxJUUX8jA/Z5ivMcREBOWkNoOQqQfOC/HRPw3enq4wGGkS1slNvcU97fDd
 bKJV4jIfKFruTPCk/8LU8A982hKD8Fu+xwF8lx63QG2EK0afLtOw4lUrH+WYlB7EqUYh
 C0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=UNI0f/x+A3VFfyuWNL93KS553nptZeSA3sVd8g/VcJE=;
 fh=eSGTpZ/+rqpDSLRAETcqVHJrTBA7Fx3Zl7gWkQXUacs=;
 b=dpYYSXfddFslbeDtIzprFK3sRDcA1oQiSJ6XCk9EY0s3akbX5YqrIlPf+iGQP7KFWg
 q+IEnBmshqqrP+GkX3vEySUYIAcsLdC5TnQJ+N6CGWYEzhuvcmHH/2IuIVwyyenMgsE9
 G0XZltWNQ8hShhuHXVPyTY31kaH2DmRARuqfjSfp46u5Lu3fCXh80vvsy3hhab5/6/Cd
 pKkBXUa258AsQOdKkJt7JA00HVmWrI3dfj+4OAp86gZEcKKDqYgxx4rUaWjytYnq9Nf/
 xse7/FeDRpwu5w3RN8ts7pIR0aJyrpedIWw8mXlUNVUahQVTr3w3SvI9MNR9nj4uKDMU
 3bVA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793438989; x=1794043789;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UNI0f/x+A3VFfyuWNL93KS553nptZeSA3sVd8g/VcJE=;
 b=BnzKcs2IzvdZEf7SmAwuI9ahbadacofnYs9tuf5lEY/EUsynkGPJdmWQ6maiMpizow
 Sg5QhSv7LRH4OORB0ph+JDUB6JVHmfoA5vw/JJAeNDs4/9GRD++l8P47QRuUKwAj/4qI
 XL+4dC2CMeifXuEgDq0vGG3C3bpQkG334HbQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793438989; x=1794043789;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UNI0f/x+A3VFfyuWNL93KS553nptZeSA3sVd8g/VcJE=;
 b=MqQBlJAnQbE4usoA2/LErri3NawrpSTY6XGMEX9vA1pI4ysZYXmUjYQPJtf8J8uFke
 QkcwN0hhRtgVq8cd0fPSendWHXbJzJ/U//W4xmf0egRD+By4qKJECAE8Kgm1ZWbvEMXT
 oLOvIAgNlAfoN9GdK8c2O+PALPfiH78e/80bwq+NPvlsB8HeMDHB1XV+Jdbe6cILaRwR
 NTTa5f8a3Gfm1CnWxFq7SKsGKYJdPDGZ7IYtvOupzU6aO8xD+g0yJ+cegJ/kClXq9pG/
 FtN4nGZnO3b851zQrTkFSxJmAwYF82W0+AHxjV3dfyTDAwKZKSY9Q51qfW8W0X4xfZSh
 VaEQ==
X-Gm-Message-State: AFq9FYLx88RscntD/vIO+5Ff4s0Pl40xeqgU1Qln9d0jDuS87XHC/ZoQ
 ZkvoGAoIekAQMwF8eoR6vjj6Q7zwbs+uqoPjkWoe3EkmVfvEITZ2OjhaRVpuApi/5qgZqoKBP+M
 VHi9bRWKOAL4vUUt+i0WjhMBRDnKzZK5i22Echih4
X-Gm-Gg: AYBFou0rFbBFL98s/KlMIZ9/KFlLuuiUI0WA9MuzfyPpZgQX9wp58pXZnpGbDjf92Vr
 pBDLe7f+cRR2kvCbUugGkVJjJWIw7iiiB2edO4x1AOmmwowckqp2ro7kaQtqGKWsBrU/bC29c4g
 fX7sWux3DMjHC9iCbcu2rQr3C2ebGMEh/z9sOOWX5xwBYty+K1LfUkJgou3DFaoitf0B2j8nedF
 gOYoBN8Gyfk6SyLfBqVQ+nQgyi0fQ7lpYYawghR1C5pveaCDcaGWnpiMj4nGSG33L+tbQYdlVc1
 lS54Jki9E3qpH+/aW00aKRdof3T6PYcOSDTD5jtzfspi30FnRJu0gLVrjmcUEuU1OiX0y0ISptW
 uA7zQYa0Rc8MOaSPMqyeGIgWSFMy6u/yC4kOblVbURi+46r4t7DIl54yw9uwJ4INBQAgbdcA=
X-Received: by 2002:a17:90a:e7ca:b0:3ad:3715:d21 with SMTP id
 98e67ed59e1d1-3ae897d460fmr4153818a91.49.1793438989307; Sat, 31 Oct 2026
 02:29:49 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:29:45 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:01:55 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-b4-reset-edl-rebootmode-v2-4-f690da515804@oss.qualcomm.com>
References: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
 <20261020-b4-reset-edl-rebootmode-v2-4-f690da515804@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:29:45 -0700
X-Gm-Features: AclHuK8M2R5n44nGE7N8MIzIACgn2Kw5_KETA13xHQNSInKHxL0hoAFItH9E7lo
Message-ID: <CAFLszThZsAOhzHUZT=c-joKuv_=R+F=ThcJWEocUYLBR6EtZUA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] cmd: reset: dispatch named reset modes via the
 reboot-mode framework
To: balaji.selvanathan@oss.qualcomm.com
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Vincent Jardin <vjardin@free.fr>, Michael Srba <Michael.Srba@seznam.cz>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Balaji,

On 2026-10-20T16:46:19, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> cmd: reset: dispatch named reset modes via the reboot-mode framework
>
> Teach the "reset" command to trigger the reset modes registered with the
> reboot-mode framework in addition to the existing cold and warm resets:
>
>   reset            cold reset (unchanged)
>   reset -w         warm reset (unchanged)
>   reset -m <mode>  reset into a mode declared in the device tree
>   reset -l         list the available reset modes
>
> For example "reset -m edl" enters Qualcomm EDL/download mode when the
> psci device tree node carries a "reboot-mode" subnode with
> "mode-edl = <0x80000000 0x00000001>". The command never parses the magic
> values itself; it hands the mode name to reboot_mode_request(), so the
> values stay in the device tree and are not hardcoded per SoC.
>
> The handling lives in a wrapper around do_reset() in cmd/boot.c, so it
> works regardless of whether the board uses the sysreset uclass or an
> arch-specific do_reset(). An unknown mode prints the registered modes and
> fails, rather than silently falling through to a cold reset.
> [...]
>
>  cmd/boot.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 70 insertions(+), 2 deletions(-)

> diff --git a/cmd/boot.c b/cmd/boot.c
> @@ -56,11 +60,75 @@ U_BOOT_CMD(
> -	"reset -w - warm reset if implemented"
> +	"reset -w - warm reset if implemented\n"
> +#if IS_ENABLED(CONFIG_DM_REBOOT_MODE)
> +	"reset -m <mode> - reset into a mode declared in the device tree\n"
> +	"reset -l - list the available reset modes\n"
> +#endif

The help text now ends with a newline in both configurations, so 'help
reset' shows an extra blank line. This affects boards without
DM_REBOOT_MODE too, whose help text did not change before. Please can
you put the '\n' at the start of each new line instead, e.g. '\nreset
-m <mode> - ...', and drop the one added after 'warm reset if
implemented'?

Regards,
Simon
