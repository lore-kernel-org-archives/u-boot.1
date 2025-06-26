Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF9CC7EE32
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 12:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E44DE82AA4;
	Thu, 26 Jun 2025 14:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Ouui/8JK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA8BD82DA1; Thu, 26 Jun 2025 14:59:55 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8BAF80E9A
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 14:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750942778; x=1751547578; i=xypron.glpk@gmx.de;
 bh=GJM8404dQd5JndL84Vm30W4KWg5LI/+/7zKp059rIUo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Ouui/8JKXOlJCb7qdhbOyysIF1hVosl2boYOSXzyIJZpAhlDSEXmn7CVM23aG6LS
 HI+MtjWRHPxckUWf87nb/pJwP7j/Z0sZrZuEzyNo8WjYsrZyPJAiXh+CBHvOLHJER
 EOQm18vLNLh+ST0Egf3nNqy118zzvVicsQKkG2mboyE8W/YDBMx0J3vDtbrq7jM2/
 /ojucgEHV33uwk50lSMgMg0Wyp7Q+Ia7dyE+pnlJXJmgBK8OmDH+DW8+B3aqgWues
 UFPdjbuojTfSayNPTQEYi33+aoqRbg6C8TV04ceRmfYxQJXCNdZERj5+sUgbgRnZC
 FVQT21l5FbJTkHntqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzuH-1v15wj0tVn-00apaq; Thu, 26
 Jun 2025 14:59:38 +0200
Message-ID: <95d9ea66-1fd8-4f8f-9a5b-b4f4973f300c@gmx.de>
Date: Thu, 26 Jun 2025 14:59:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cmd: eficonfig: add support for URI device path
 based boot options
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
References: <20250624120730.2158194-1-sughosh.ganu@linaro.org>
 <20250624120730.2158194-2-sughosh.ganu@linaro.org>
 <713c7bf0-25d9-43fc-9e98-486947fd58fb@gmx.de>
 <CADg8p94THmBduwEDZK7SSeAgtN8JcAd8cv+aWDiL_MrsK4=vNQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CADg8p94THmBduwEDZK7SSeAgtN8JcAd8cv+aWDiL_MrsK4=vNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DQiSa9ofiWIPnywZYgZgQA3G9IrOlXZB5WgW7GhvOvjs1jiBuGz
 gfytkDTy/NNnizRuf0ELI/mzkcFil0f3t8xm30NmWf8ShSYwPHGxJO9r2O/kx4wwkSW6yV/
 P4KXeWb+lQma6XYkBDjVadDlsHass2TWSH2HEJ/4mw1CJk806kB8iaIrFDTOZyDfYsSQhOr
 6vALsXKnEOHHWHH6/FOTA==
UI-OutboundReport: notjunk:1;M01:P0:JVyt/PDmxFY=;unDk75lKgX9w6ekSRZLVryJgAl0
 6c5m5zWBlG/jXH8lIsTDcIp+bKYJkaELxyuYxhmNQoPXZ29plcDMYvL/gY5QVLFfYdlHlgWgk
 NpmQiqzeNCqQrop89mj9XbMml9fUCPi6IhMugcTi0j2SmXpGRqluTFtAcOBkOLQpdTQIZ3dW4
 l6hT+Dgw5/rxBFyiIkT+v5nSC/zF7BnKRdPmmt55WEVXU0IPKB+2HqFe+c56tAzvQGo/uaoGg
 P3x20IlXK9ixfEuIL8oI7QucDXUZCjF0sPmWCtzHvGLCHlQVbqtvrqmKQXWGkyHf4kPO0Aruh
 OGbPVQkYOn0Lgv5zNuOJwn5K4FNmlXgqt9nqLnTK0IcNBHHHm4pDEoP2SsxgxDTDqbRla05PI
 +iThWGo5JOw1GjaJuRMuBwfXt3p03Nm2mZwgCTmRm2yv6lMk81vkrAC998RKT+XPJjMastPJt
 gLZ6a7DLbeB/tKP0upOrA74STS3inep32Ga1NBa+IU05HvmA8wxLAZR7RFtWQwTOsjnQN+a3+
 Pu17cHNSbc15i3xHLPSsfvSPC8V5Xyr0RJStrgC1Q/hm42JNtF/yIqRYO7XbGHuAqTMzUv9Qt
 8TuQ8CzDvzGUB3/DE861H7q9MEScFt3baewJiwPY6PakPVV1mg0f88MWuwoE1wbvVIPZnp1x6
 UxEdZtwJEuWS+90z8enxKEetkfgXIiIt5VSlKfLD+x//+cgojaNOD2iSWMaEn9HYqkCu1sQqw
 3FTYHePON/iTtE+1PpfajAvjZw0nORejmzBQXCVWO1IRzXvfqLIY7eysgno9d9YCE2EAHetD5
 Ps7daM5LEDicxhd9lZMu3EXexJ11YvKlqG5i7Rgl+t64NaWuXHNbOP9x88Zvb849qzOuH7K+L
 esc6BuLFu/XX9f+wltuOSZJZ8vZumS5LI9y8mXnLfia8q0W/gVUA0zndNLJKVguedpZSD6Qcd
 SMCO6QVT9DCwGHHc4TG5lmO0E+eM6aaovgvNxML1bIV984m4w3f/8S4pq4kAnm9ZBHFbiN4XC
 OS1yutwMG6MbquErOED8zB44L6NZeM7YzGd0mWK+plbjbENP+RXzS9KFJMq20i3LELTX4/Xrz
 rqhHOJMGRBHydzAWrRFYeTeP+D4D+8BzlIuImAKNiNoB0L57Um2V+jJaOmjiFLmd/GILv+sbm
 i+5iu/a5nIHwLDrOiKnSNJBQes4M3TGkmNsJ4UIvdJu8kFDup+MQPsQ5/h7dsPTuCah/LyHny
 EUtdV9cJ94ChXub0I6GwNabus6eahZ7MvY/EQpYfr+8AgKhL4Q7foK9PSRmvNOVi+CR6QEEoP
 hdpuyNSoouHaMwzh97RAk9Ts30sc2UsD+jrr9qcM5z6d64lkWlZpiTR55v1kJNJ8oaZ4ahQjQ
 LBu4juGQm6ejHS1ibxSzKST7plu2ZIrKoKnuKt7PnXaGT4Dk6F/IZ9B9IE241jtONhgwow6BA
 HivwW07S/1Hiem/uKC7RbxPTOwYPmntcJk77Yr1OCtWoF6I55QLqbLwqo6HDr9zHOwz3s46+o
 YVep6uWPIp91V53gqQBEUzyUksEWKjNsopStXt19k/i3Lj2uvdQncrgegetxVHfVAeu3mo3kx
 GI8mA4iLEXd2nnipXt/XR/Nc2OM0asrhk4NUUfolGgIW50Mwt5MAgKG15TcUdQP8vEaubGbQJ
 PmLNPOomu71vLzxP3Xmm6lHCZEYiFoIlGsIL+/U+BgdIh3scG8iMzyMmaTL4VAaTwVPjRQJ0E
 i9qck16tYyBmSz9TrJUPtve99Y+oleMb/Kqz2AkhgcNJ1H4w7Y6kpTTbY9bgEdeJTR05bi9a2
 DEEKwbkUmO7RQNtNDcNM1Bf1teCz/7HpCnCqd2yOhaOx5kdSAPj67aKtKOvCING7rXVXTJzF9
 qlPOQLx9Fs4bVGbTR82biLdIH/PUDFj2lrWm6Bu47VQ7pgwzZxD6vD2VBG2PrYlL9QR/Ht8RR
 0v2PqjSnJgOfco3atx8hSN8PTMyR/xZciTEsYxIi3rZrHJMjw5NZhO3rIPC7kpkEsSA54QJ5x
 EuCHmxqafGSs2T1Yig3HWtp5u2STSoaoIAGZ0LkEkf3Lo72X2LJDt2rxxIwiGf9LYbIBE9pIw
 BZXjFozLMcefGSeeg6lIlPyCGmF4bsaXD1ezrDxZsr5/dRuKQotyIaWgACp/uQMIlzTGXxnpx
 PLmIfAXiIU308FgPMO171FeGsNrZupKLnbsKUZ77ccSmRBywoZrDQ+oHShzKgvkdQvJ6wEvGp
 i/KjAu0KUJ/CQDNRep7gWGpe+DZmwtiGrhY+9WZhoY+w0XB7u9VHqheoNTsjUfXTPm9ZZ61MF
 3urgI6MrrEtIWlAgE4gwWxS5mW11b53UpKW7eCt9hnSh0K3+XXeU38pp+wgApKaV0ugNe6huZ
 UicIGG1RCtEWlEzTg07EIT/FGv7x9JILiZ6STKOLx9oB4goCX3GRYRt3EE+P9IWZvgHtZ4mKe
 SoqAFGU6IVxAHUAyj02hVVpf35n0P8BylUcgNikfrxepcEmcdW/+UOsIrKXrSoPAh3Fb1lWVg
 7hBU5+49fDG41zPfsndKa6ndnDGny6M5TMvYb7Zn2uueGkRUdkP+oPJ/eTsM9fDclP4mMp3kY
 IQxfCExLFpMK7RfoqLV+Hf+HzdWRmpZH6BJQvQT8aPdONo+iHTJujKNq1IKV7q3ck9jLnVeNJ
 +bIhiwDih6tky0g8DjUxqKFACTTeLhqFpsDqtE0cgIfXFV5Mx2O6DlWu0ihl1eFSWNRNw+NXi
 DliEv5wjniJ0hPz6eF3KoRyl1EV9eJr7s4qeutidIh8FYuXG8HjnzAqG9l/13CnktD/C6TQO0
 m+x3ainUF7AOQrsMiiXSUf3LZaOO8nSA5UIGD/Np/HqVCV1R3j9eNZOqX0eMDGJZQk33/P5Yj
 XBBB0GZTlVQ2G+KcQSfWAPJSL2fhmw6HLZJLHJVBMe8be6/oMBRbAlNuAIwWIc4mX01+AZy0d
 DnFFu8dcd+l8Sv0gRdBqwT9lZkRfPxDPmFYIyAhM0YIAFkz1Nf/t7VR+hU204qh5bWkajyMUK
 Hv4GCdRvE8x6cVTCN08Xvohw63vrHQO1ZXgcX/+WLn/xN2yD/4yJnKn649pF7JtDG8kpf3bJz
 7AiDXmcnpXo+QljQ4bM5KLP9FM7QOOMf8eqo3lwRSTBz5PgbsNhDPhRcRuwWvwsRB+WwnEAAi
 XYHN9joKBGKvn6m1zH4+2pnVvtqH4Oh2bsowouPvh7sa6LUEUjqWDszE/PcHClyW9Uiy+NowV
 yuEfLngZ/E1WPSwHpmsTEPOWuwlsCTTIiapA4mZ54utVadAUjdH5QBK9bVKmRv0dziPkvisL3
 qarB5SLn1k2JgwOOxu6sBqopwXXP62GhIGXCTXBa0T43BiOJw2dYt5GyjsuSiayBxiHtozdRx
 Jw2ozAmHfNd4XlzZkR9bjWC6LFhy4ezTYJ0UuN2nvtvRK9Rr1LY+sNWVERRKdobxktkQbFPqv
 5+wuA2vK1rIpLyDGm8REyozJuE3bOBkC0UZD7+YchZRtRG2aehxXPnwbMf0DPl+JDR5nLQT2O
 JKIV99vPKgFn5dnZ4JNKeF8=
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

On 26.06.25 11:28, Sughosh Ganu wrote:
> On Thu, 26 Jun 2025 at 13:52, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 24.06.25 14:07, Sughosh Ganu wrote:
>>> The eficonfig command provides a menu based interface for maintenance
>>> of the EFI boot options. Add support for adding a URI based boot
>>> option. This boot option can then be used for HTTP boot.
>>>
>>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>>> ---
>>> Changes since V1:
>>> * Move the option for entering the URI under the boot file.
>>> * All corresponding changes needed for the above change.
>>>
>>>    cmd/eficonfig.c      | 113 ++++++++++++++++++++++++++++++++++++++++=
=2D--
>>>    include/efi_config.h |   4 ++
>>>    2 files changed, 109 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
>>> index 6e14d34a6bd..917d79b8023 100644
>>> --- a/cmd/eficonfig.c
>>> +++ b/cmd/eficonfig.c
>>> @@ -35,6 +35,7 @@ static int avail_row;
>>>
>>>    #define EFICONFIG_DESCRIPTION_MAX 32
>>>    #define EFICONFIG_OPTIONAL_DATA_MAX 64
>>> +#define EFICONFIG_URI_MAX 512
>>
>> I am not aware of as standard setting a limit on URI sizes.
>>
>> https://www.rfc-editor.org/rfc/rfc9110#section-4.1-5 has this
>> recommendation:
>>
>> It is RECOMMENDED that all senders and recipients support, at a minimum=
,
>> URIs with lengths of 8000 octets in protocol elements.
>>
>> We should determine the length of the URI when the user makes his input=
.
>=20
> I had checked the corresponding RFC to check if there was a mention of
> size limit on the URI, and there is none. There is a mention about
> some applications using 2K as a limit for the URI length. But in
> U-Boot's context, I think that 512 bytes is a good enough limit, given
> that we are using the URI primarily for specifying distro installation
> image's path.
>=20
> Also, the handle_user_input() function in the eficonfig tool expects a
> size limit to be provided for all the user input, and I think this is
> a sane thing to do rather than allowing the user to input random
> strings. Do you see a realistic use-case where a URI of more than 512
> characters might be expected for a boot option?

I do not control how people are setting up their image servers. E.g. if=20
you create images on the fly and pass GET parameters URI's can become=20
long. That is why I refer to the RFC which indicates bounds. But I agree=
=20
that in most cases 512 will be enough.

You are using efi_console_get_u16_string() which is not usable to edit=20
strings that are longer than a screen line properly. If I enter 512=20
times the character "a" and the backspace 512 times, I get:

   ** Edit URI **

   enter HTTP Boot URI:
a
a
a
a

I did not expect "Press ENTER to complete, ESC to quit" to be=20
overwritten and I did not expect characters at the start of the line not=
=20
being deleted when backspacing.



>=20
>>
>>>    #define EFICONFIG_MENU_HEADER_ROW_NUM 3
>>>    #define EFICONFIG_MENU_DESC_ROW_NUM 5
>>>
>>> @@ -538,6 +539,31 @@ struct efi_device_path *eficonfig_create_device_p=
ath(struct efi_device_path *dp_
>>>        return dp;
>>>    }
>>>
>>> +static struct efi_device_path *eficonfig_create_uri_device_path(u16 *=
uri_str)
>>> +{
>>> +     char *pos, *p;
>>> +     u32 len =3D 0;
>>> +     efi_uintn_t uridp_len;
>>> +     struct efi_device_path_uri *uridp;
>>> +
>>> +     len =3D utf16_utf8_strlen(uri_str);
>>> +
>>> +     uridp_len =3D sizeof(struct efi_device_path) + len + 1;
>>> +     uridp =3D efi_alloc(uridp_len + sizeof(EFI_DP_END));
>>> +     if (!uridp)
>>> +             return NULL;
>>> +
>>> +     uridp->dp.type =3D DEVICE_PATH_TYPE_MESSAGING_DEVICE;
>>> +     uridp->dp.sub_type =3D DEVICE_PATH_SUB_TYPE_MSG_URI;
>>> +     uridp->dp.length =3D uridp_len;
>>> +     p =3D (char *)&uridp->uri;
>>> +     utf16_utf8_strcpy(&p, uri_str);
>>> +     pos =3D (char *)uridp + uridp_len;
>>> +     memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
>>> +
>>> +     return &uridp->dp;
>>> +}
>>> +
>>>    /**
>>>     * eficonfig_file_selected() - handler of file selection
>>>     *
>>> @@ -983,6 +1009,22 @@ static efi_status_t eficonfig_boot_add_optional_=
data(void *data)
>>>                                 "  enter optional data:");
>>>    }
>>>
>>> +/**
>>> + * eficonfig_boot_add_uri() - handle user input for HTTP Boot URI
>>> + *
>>> + * @data:    pointer to the internal boot option structure
>>> + * Return:   status code
>>> + */
>>> +static efi_status_t eficonfig_boot_add_uri(void *data)
>>> +{
>>> +     struct eficonfig_select_file_info *file_info =3D data;
>>> +
>>> +     return handle_user_input(file_info->uri, EFICONFIG_URI_MAX, 24,
>>> +                              "\n  ** Edit URI **\n"
>>> +                              "\n"
>>> +                              "  enter HTTP Boot URI:");
>>> +}
>>> +
>>>    /**
>>>     * eficonfig_boot_edit_save() - handler to save the boot option
>>>     *
>>> @@ -998,7 +1040,8 @@ static efi_status_t eficonfig_boot_edit_save(void=
 *data)
>>>                bo->edit_completed =3D false;
>>>                return EFI_NOT_READY;
>>>        }
>>> -     if (u16_strlen(bo->file_info.current_path) =3D=3D 0) {
>>> +     if (u16_strlen(bo->file_info.current_path) =3D=3D 0 &&
>>> +         u16_strlen(bo->file_info.uri) =3D=3D 0) {
>>>                eficonfig_print_msg("File is not selected!");
>>>                bo->edit_completed =3D false;
>>>                return EFI_NOT_READY;
>>> @@ -1027,6 +1070,13 @@ efi_status_t eficonfig_process_clear_file_selec=
tion(void *data)
>>>        return EFI_ABORTED;
>>>    }
>>>
>>> +static struct eficonfig_item select_boot_file_menu_items[] =3D {
>>> +     {"Select File", eficonfig_process_select_file},
>>> +     {"Enter URI", eficonfig_boot_add_uri},
>>> +     {"Clear", eficonfig_process_clear_file_selection},
>>> +     {"Quit", eficonfig_process_quit},
>>> +};
>>> +
>>>    static struct eficonfig_item select_file_menu_items[] =3D {
>>>        {"Select File", eficonfig_process_select_file},
>>>        {"Clear", eficonfig_process_clear_file_selection},
>>> @@ -1042,20 +1092,35 @@ static struct eficonfig_item select_file_menu_=
items[] =3D {
>>>    efi_status_t eficonfig_process_show_file_option(void *data)
>>>    {
>>>        efi_status_t ret;
>>> +     unsigned int menu_count;
>>>        struct efimenu *efi_menu;
>>> +     struct eficonfig_item *menu_items;
>>> +     struct eficonfig_select_file_info *file_info =3D data;
>>> +
>>> +     menu_items =3D file_info->boot_file_option ? select_boot_file_me=
nu_items :
>>> +             select_file_menu_items;
>>> +
>>> +     menu_count =3D file_info->boot_file_option ?
>>> +             ARRAY_SIZE(select_boot_file_menu_items) :
>>> +             ARRAY_SIZE(select_file_menu_items);
>>>
>>> -     select_file_menu_items[0].data =3D data;
>>> -     select_file_menu_items[1].data =3D data;
>>> -     efi_menu =3D eficonfig_create_fixed_menu(select_file_menu_items,
>>> -                                            ARRAY_SIZE(select_file_me=
nu_items));
>>> +     menu_items[0].data =3D data;
>>> +     menu_items[1].data =3D data;
>>> +     menu_items[2].data =3D data;
>>> +
>>> +     efi_menu =3D eficonfig_create_fixed_menu(menu_items, menu_count)=
;
>>>        if (!efi_menu)
>>>                return EFI_OUT_OF_RESOURCES;
>>>
>>> -     ret =3D eficonfig_process_common(efi_menu, "  ** Update File **"=
,
>>> +     ret =3D eficonfig_process_common(efi_menu,
>>> +                                    file_info->boot_file_option ?
>>> +                                    "  ** Update File/URI **" :
>>> +                                    "  ** Update File **",
>>>                                       eficonfig_menu_desc,
>>>                                       eficonfig_display_statusline,
>>>                                       eficonfig_print_entry,
>>>                                       eficonfig_choice_entry);
>>> +
>>>        if (ret !=3D EFI_SUCCESS) /* User selects "Clear" or "Quit" */
>>>                ret =3D EFI_NOT_READY;
>>>
>>> @@ -1268,6 +1333,7 @@ static efi_status_t prepare_file_selection_entry=
(struct efimenu *efi_menu, char
>>>        u16_strlcat(file_name, file_info->current_path, len);
>>>        ret =3D create_boot_option_entry(efi_menu, title, file_name,
>>>                                       eficonfig_process_show_file_opti=
on, file_info);
>>> +
>>>    out:
>>>        free(devname);
>>>        free(file_name);
>>> @@ -1340,6 +1406,16 @@ out:
>>>        return ret;
>>>    }
>>>
>>
>> Please, document all functions according to
>> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentatio=
n
>=20
> So I have had this comment from you on my other patches as well. I am
> not adding any API in my patch. What exactly is the rule for adding
> function documentation? I can understand if some static function
> happens to be doing a lot of work, and then it would be easier to
> understand its functionality through comments. But I don't think any
> function being added in this patch qualifies for such documentation
> being needed.

Developers succeeding you will want to know what each function is doing.=
=20
We should document non-API functions as well.

>=20
>>
>>> +static void fill_dp_uri(struct efi_device_path *dp, u16 **uri_str)
>>> +{
>>> +     u16 *p =3D *uri_str;
>>> +     struct efi_device_path_uri *uridp;
>>> +
>>> +     uridp =3D (struct efi_device_path_uri *)dp;
>>> +
>>> +     utf8_utf16_strcpy(&p, uridp->uri);
>>> +}
>>> +
>>>    /**
>>>     * fill_file_info() - fill the file info from efi_device_path struc=
ture
>>>     *
>>> @@ -1392,10 +1468,13 @@ static efi_status_t eficonfig_edit_boot_option=
(u16 *varname, struct eficonfig_bo
>>>        size_t len;
>>>        efi_status_t ret;
>>>        char *tmp =3D NULL, *p;
>>> +     u16 *current_path =3D NULL;
>>>        struct efi_load_option lo =3D {0};
>>>        efi_uintn_t dp_size;
>>>        struct efi_device_path *dp =3D NULL;
>>>        efi_uintn_t size =3D load_option_size;
>>> +     struct efi_device_path *dp_volume =3D NULL;
>>> +     struct efi_device_path *uri_dp =3D NULL;
>>>        struct efi_device_path *device_dp =3D NULL;
>>>        struct efi_device_path *initrd_dp =3D NULL;
>>>        struct efi_device_path *fdt_dp =3D NULL;
>>> @@ -1464,6 +1543,14 @@ static efi_status_t eficonfig_edit_boot_option(=
u16 *varname, struct eficonfig_bo
>>>                goto out;
>>>        }
>>>
>>> +     bo->file_info.uri =3D calloc(1, EFICONFIG_URI_MAX * sizeof(u16))=
;
>>
>> Where is the matching free()?
>=20
> There is one being added below.
>>
>>> +     if (!bo->file_info.uri) {
>>> +             ret =3D  EFI_OUT_OF_RESOURCES;
>>> +             goto out;
>>> +     }
>>> +
>>> +     bo->file_info.boot_file_option =3D true;
>>> +
>>>        /* copy the preset value */
>>>        if (load_option) {
>>>                ret =3D efi_deserialize_load_option(&lo, load_option, &=
size);
>>> @@ -1481,7 +1568,10 @@ static efi_status_t eficonfig_edit_boot_option(=
u16 *varname, struct eficonfig_bo
>>>                u16_strcpy(bo->description, lo.label);
>>>
>>>                /* EFI image file path is a first instance */
>>> -             if (lo.file_path)
>>> +             if (lo.file_path && EFI_DP_TYPE(lo.file_path, MESSAGING_=
DEVICE,
>>> +                                             MSG_URI))
>>> +                     fill_dp_uri(lo.file_path, &bo->file_info.uri);
>>> +             else
>>>                        fill_file_info(lo.file_path, &bo->file_info, de=
vice_dp);
>>>
>>>                /* Initrd file path (optional) is placed at second inst=
ance. */
>>> @@ -1512,6 +1602,9 @@ static efi_status_t eficonfig_edit_boot_option(u=
16 *varname, struct eficonfig_bo
>>>                        goto out;
>>>        }
>>>
>>> +     if (utf16_utf8_strlen(bo->file_info.uri))
>>> +             uri_dp =3D eficonfig_create_uri_device_path(bo->file_inf=
o.uri);
>>> +
>>>        if (bo->initrd_info.dp_volume) {
>>>                dp =3D eficonfig_create_device_path(bo->initrd_info.dp_=
volume,
>>>                                                 bo->initrd_info.curren=
t_path);
>>> @@ -1536,7 +1629,10 @@ static efi_status_t eficonfig_edit_boot_option(=
u16 *varname, struct eficonfig_bo
>>>                efi_free_pool(dp);
>>>        }
>>>
>>> -     dp =3D eficonfig_create_device_path(bo->file_info.dp_volume, bo-=
>file_info.current_path);
>>> +     dp_volume =3D bo->file_info.dp_volume;
>>> +     current_path =3D bo->file_info.current_path;
>>> +     dp =3D uri_dp ?
>>> +             uri_dp : eficonfig_create_device_path(dp_volume, current=
_path);
>>>        if (!dp) {
>>>                ret =3D EFI_OUT_OF_RESOURCES;
>>>                goto out;
>>> @@ -1560,6 +1656,7 @@ out:
>>>        free(tmp);
>>>        free(bo->optional_data);
>>>        free(bo->description);
>>> +     free(bo->file_info.uri);
>=20
> This is the matching free.

ok

Best regards

Heinrich

>=20
> -sughosh
>=20
>>>        free(bo->file_info.current_path);
>>>        free(bo->initrd_info.current_path);
>>>        free(bo->fdt_info.current_path);
>>> diff --git a/include/efi_config.h b/include/efi_config.h
>>> index d7c1601137e..4438933db6a 100644
>>> --- a/include/efi_config.h
>>> +++ b/include/efi_config.h
>>> @@ -82,15 +82,19 @@ struct eficonfig_item {
>>>     * @current_volume: pointer to the efi_simple_file_system_protocol
>>>     * @dp_volume:              pointer to device path of the selected =
device
>>>     * @current_path:   pointer to the selected file path string
>>> + * @uri:             URI for HTTP Boot
>>>     * @filepath_list:  list_head structure for file path list
>>>     * @file_selectred: flag indicates file selecting status
>>> + * @boot_file_option:        flag indicating if option is for boot fi=
le
>>>     */
>>>    struct eficonfig_select_file_info {
>>>        struct efi_simple_file_system_protocol *current_volume;
>>>        struct efi_device_path *dp_volume;
>>>        u16 *current_path;
>>> +     u16 *uri;
>>>        struct list_head filepath_list;
>>>        bool file_selected;
>>> +     bool boot_file_option;
>>>    };
>>>
>>>    void eficonfig_print_msg(char *msg);
>>

